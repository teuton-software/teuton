#!/usr/bin/env ruby

require "sinatra"
require_relative "../utils/config_file_reader"

get "/" do
  filename = "examples/03-remote_hosts/config.yaml"
  filepath = File.join(Dir.pwd, filename)
  data = ConfigFileReader.read_yaml(filepath)
  names = data[:cases][0].keys
  erb :form, locals: { :names => names }
end

post "/submit" do
  # Los datos del formulario se encuentran en el objeto 'params'
  erb :feedback
end
