require "sinatra/base"
require "socket"
require_relative "../utils/config_file_reader"
require_relative "../utils/name_file_finder"

class ConfigServer < Sinatra::Base
  LINE = "-" * 50
  PORT = 8080
  REQUEST_IP_PARAM_NAME = :tt_request_ip
  set :bind, "0.0.0.0"
  set :port, PORT

  def self.configure_project(projectpath)
    @@projectpath = projectpath
    finder = NameFileFinder.new
    finder.find_filenames_for(@@projectpath)
    @@config_filepath = finder.config_path
    @@config = ConfigFileReader.read(@@config_filepath)

    run!
    save_global_config
  end

  def self.save_global_config
    @@config[:global][:tt_include] = "config.d"
    @@config[:cases] = []
    @@config.delete(:alias) if @@config[:alias].empty?
    data = convert_symbol_keys_to_string(@@config)
    File.write(@@config_filepath, data.to_yaml)
  end

  def initialize
    super
    @data = {}

    print LINE
    puts "   ConfigServer URL: " + Rainbow("http://#{get_local_ip}:#{PORT}").bright
    puts ""
    print "   Project path : #{@@projectpath}"
    print "   Global params (#{@@config[:global].size})"
    @@config[:global].each { |key, value| print "   * #{key} : #{value}" }
    @@config[:cases].first.delete(REQUEST_IP_PARAM_NAME)
    print "   Cases params (#{@@config[:cases].first.size})"
    @@config[:cases].first.keys.each { |key| print "   * #{key}" }
    print LINE
  end

  get "/" do
    names = @@config[:cases].first.keys
    erb :form, locals: {names: names}
  end

  post "/submit" do
    @data[request.ip] = params.clone
    @data[request.ip][REQUEST_IP_PARAM_NAME] = request.ip
    puts "==> [RECEIVED #{@data.size}] Data from #{request.ip}"
    save_case_config(@data[request.ip])
    erb :feedback
  end

  at_exit do
    puts LINE
  end

  def save_case_config(data)
    folder = File.join(@@projectpath, "config.d")
    Dir.mkdir(folder) unless Dir.exist?(folder)
    filepath = File.join(folder, "remote_#{data[REQUEST_IP_PARAM_NAME]}.yaml")
    File.write(filepath, data.to_h.to_yaml)
  end

  private_class_method def self.convert_symbol_keys_to_string(input)
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

  private

  def get_local_ip
    UDPSocket.open do |s|
      s.connect "208.67.222.222", 1
      s.addr.last
    end
  rescue SocketError
    "127.0.0.1"
  end

  def print(msg)
    puts Rainbow(msg).white
  end
end
