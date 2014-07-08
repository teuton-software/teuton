#!/usr/bin/ruby
# encoding: utf-8

require 'net/ssh'

Net::SSH.start("192.168.1.201", "profesor", :password => "profesor") do |ssh|
  # capture all stderr and stdout output from a remote process
  comando="hostname -f"
  output = ssh.exec!(comando)
  puts "Ejecutando el comando: #{comando}"
  puts output
end

ssh=Net::SSH.start("192.168.1.201", "profesor", :password => "profesor")
comando="whoami"
output = ssh.exec!(comando)
puts "Ejecutando el comando: #{comando}"
puts output
ssh.close
