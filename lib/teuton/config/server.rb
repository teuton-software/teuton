#!/usr/bin/env ruby

require "sinatra/base"
require_relative "../utils/config_file_reader"
require_relative "../utils/name_file_finder"

class ConfigServer < Sinatra::Base
  get "/" do
    projectpath = "examples/03-remote_hosts"
    finder = NameFileFinder.new
    finder.find_filenames_for(projectpath)
    config_path = finder.config_path

    data = ConfigFileReader.read(config_path)
    names = data[:cases].first.keys
    erb :form, locals: {names: names}
  end

  post "/submit" do
    # Los datos del formulario se encuentran en el objeto 'params'
    erb :feedback
  end

  at_exit do
    puts "Closing ConfigServer"
  end
end

ConfigServer.run!
