require "sinatra/base"
require "socket"
require_relative "../utils/config_file_reader"
require_relative "../utils/name_file_finder"

class ConfigServer < Sinatra::Base
  LINE = "-" * 50
  PORT = 8080
  set :bind, "0.0.0.0"
  set :port, PORT

  def self.configure_project(projectpath)
    @@projectpath = projectpath
    finder = NameFileFinder.new
    finder.find_filenames_for(@@projectpath)
    @@config_filepath = finder.config_path
    @@config = ConfigFileReader.call(@@config_filepath)
    @@config[:global][:tt_include] = @@config[:global][:tt_include] || "config.d"

    run!
    save_global_config
  end

  def self.save_global_config
    all_cases = @@config[:cases].clone
    @@config[:cases] = all_cases.select do |c|
      c[:tt_source_file].nil? && c[:tt_source_ip].nil?
    end
    @@config.delete(:alias) if @@config[:alias].empty?
    data = convert_symbol_keys_to_string(@@config)
    File.write(@@config_filepath, data.to_yaml)
  end

  def self.convert_symbol_keys_to_string(input)
    return input if input.class != Hash

    output = {}
    input.each_pair do |key, value|
      key2 = key
      key2 = key.to_s if key.class
      value2 = value
      if value.instance_of? Hash
        value2 = convert_symbol_keys_to_string(value)
      elsif value.instance_of? Array
        value2 = []
        value.each { |i| value2 << convert_symbol_keys_to_string(i) }
      end
      output[key2] = value2
    end
    output
  end

  def initialize
    super
    @data = {}

    show_warning_and_exit if @@config[:cases].size.zero?
    show_banner
  end

  get "/" do
    erb :form, locals: {param_names: get_param_names_to_configure}
  end

  post "/submit" do
    ip = request.ip
    @data[ip] = params.clone
    @data[ip][:tt_source_ip] = ip
    puts "==> [RECEIVED DATA #{@data.size}] from #{ip}"
    save_case_config(@data[ip])
    erb :feedback
  end

  private

  def show_banner
    print LINE
    puts "   ConfigServer URL: " + Rainbow("http://#{get_local_ip}:#{PORT}").bright
    puts ""
    print "   Project path : #{@@projectpath}"
    print "   Global params (#{@@config[:global].size})"
    @@config[:global].each { |key, value| print "   * #{key} : #{value}" }
    print "   Cases params (#{get_param_names_to_configure.size})"
    get_param_names_to_configure.each { |key| print "   * #{key}" }
    print LINE
  end

  def show_warning_and_exit
    warn Rainbow("[ERROR] ConfigServer: Parameter names are missing!").bright.red
    warn Rainbow("[OPTION 1] Create one case with some params. Example:").bright.yellow
    warn Rainbow("# File: #{@@config_filepath}").white
    warn Rainbow("...").white
    warn Rainbow("cases:").white
    warn "- tt_member: TOCHANGE"
    warn "- param_name: TOCHANGE"
    warn Rainbow("...").white
    warn Rainbow("[OPTION 2] Or configure tt_include to read config files from subfolder. Example:").bright.yellow
    warn Rainbow("# File: #{@@config_filepath}").white
    warn Rainbow("global:").white
    warn "- tt_include: TOCHANGE"
    warn Rainbow("cases:").white
    warn Rainbow("...").white
    exit 1
  end

  def get_local_ip
    UDPSocket.open do |s|
      s.connect "208.67.222.222", 1
      s.addr.last
    end
  rescue SocketError
    "127.0.0.1"
  end

  def get_param_names_to_configure
    param_names = @@config[:cases].first.keys
    param_names.delete(:tt_source_ip)
    param_names.delete(:tt_source_file)
    param_names
  end

  def print(msg)
    puts Rainbow(msg).white
  end

  def save_case_config(data)
    folder = File.join(@@projectpath, @@config[:global][:tt_include])
    Dir.mkdir(folder) unless Dir.exist?(folder)
    filepath = File.join(folder, "from_#{data[:tt_source_ip]}.yaml")
    File.write(filepath, data.to_h.to_yaml)
  end
end
