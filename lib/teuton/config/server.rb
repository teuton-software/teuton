require "sinatra/base"
require_relative "../utils/config_file_reader"
require_relative "../utils/name_file_finder"

class ConfigServer < Sinatra::Base
  set :bind, "0.0.0.0"
  set :port, 8080

  def self.configure_project(projectpath)
    @@projectpath = projectpath
    finder = NameFileFinder.new
    finder.find_filenames_for(@@projectpath)
    @@config_filepath = finder.config_path
    @@config = ConfigFileReader.read(@@config_filepath)

    self.run!
    self.save_global_config
  end

  def self.save_global_config
    @@config[:global][:tt_include] = "config.d"
    @@config[:cases] = []
    File.write(@@config_filepath, @@config.to_yaml)
  end

  def initialize
    super
    @data = {}

    puts "==> [INFO] Starting configuration web server..."
    puts "==> [INFO] Project: <#{@@projectpath}>"
  end

  get "/" do
    names = @@config[:cases].first.keys
    erb :form, locals: {names: names}
  end

  post "/submit" do
    @data[request.ip] = params.clone
    @data[request.ip][:tt_request_ip] = request.ip
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
    sanitized_text = data.to_yaml.sub(/---.*?\n/m, "")
    File.write(filepath, sanitized_text)
  end
end
