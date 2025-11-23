#!/usr/bin/env ruby
require "sinatra"

get "/" do
  @names = ["tt_members", "host1_ip", "host1_username", "host1_password"]
  erb :form
end

post "/submit" do
  # Los datos del formulario se encuentran en el objeto 'params'
  erb :feedback
end
