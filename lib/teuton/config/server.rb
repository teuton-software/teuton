require "sinatra/base"
require_relative "../utils/config_file_reader"
require_relative "../utils/name_file_finder"

class ConfigServer < Sinatra::Base
  set :bind, "0.0.0.0"
  set :port, 8080
  REQUEST_IP_PARAM_NAME = :tt_request_ip

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

    puts "==> [INFO] Starting configuration web server..."
    puts "==> [INFO] Project: <#{@@projectpath}>"
  end

  get "/" do
    names = @@config[:cases].first.keys
    names.delete(REQUEST_IP_PARAM_NAME)
    erb :form, locals: {names: names}
  end

  post "/submit" do
    @data[request.ip] = params.clone
    @data[request.ip][REQUEST_IP_PARAM_NAME] = request.ip
    puts "==> [INFO] Data received from #{request.ip} (Total #{@data.size}) "
    save_case_config(@data[request.ip])
    erb :feedback
  end

  at_exit do
    puts "==> [INFO] Closing ConfigServer"
  end

  def save_case_config(data)
    folder = File.join(@@projectpath, "config.d")
    Dir.mkdir(folder) unless Dir.exist?(folder)
    filepath = File.join(folder, "remote_#{data[:tt_request_ip]}.yaml")
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

end
