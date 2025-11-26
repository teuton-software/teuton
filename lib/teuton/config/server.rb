require "sinatra/base"
require_relative "../utils/config_file_reader"
require_relative "../utils/name_file_finder"

class ConfigServer < Sinatra::Base
  set :bind, '0.0.0.0'
  set :port, 8080

  def initialize
    super

    projectpath = "examples/03-remote_hosts"
    finder = NameFileFinder.new
    finder.find_filenames_for(projectpath)
    config_path = finder.config_path
    @config = ConfigFileReader.read(config_path)
  end

  get "/" do
    names = @config[:cases].first.keys
    erb :form, locals: {names: names}
  end

  post "/submit" do
    # Los datos del formulario se encuentran en el objeto 'params'
    params[:tt_request_ip] = request.ip 
    puts "[DEBUG] #{params}"
    erb :feedback
  end

  at_exit do
    puts "[INFO] Closing ConfigServer"
  end
end
