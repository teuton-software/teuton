require "sinatra/base"
require_relative "../utils/config_file_reader"
require_relative "../utils/name_file_finder"

class ConfigServer < Sinatra::Base
  set :bind, "0.0.0.0"
  set :port, 8080

  def self.set_projectpath(projectpath)
    @@projectpath = projectpath
    self
  end

  def initialize
    super
    finder = NameFileFinder.new
    finder.find_filenames_for(@@projectpath)
    config_path = finder.config_path
    @config = ConfigFileReader.read(config_path)
    @data = {}

    puts "==> [INFO] Starting configuration web server..."
    puts "==> [INFO] Project: <#{@@projectpath}>"
  end

  get "/" do
    names = @config[:cases].first.keys
    erb :form, locals: {names: names}
  end

  post "/submit" do
    # Los datos del formulario se encuentran en el objeto 'params'
    @data[request.ip] = params
    @data[request.ip][:tt_request_ip] = request.ip
    puts "==> [INFO] Data received from #{request.ip} (Total #{@data.size}) "
    save_config(@data[request.ip])
    erb :feedback
  end

  at_exit do
    puts "==> [INFO] Closing ConfigServer"
  end

  def save_config(data)
    puts "==> Saving: #{data}"
  end
end
