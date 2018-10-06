#!/usr/bin/ruby
# load gem to use telnet tool
require 'net/telnet'

# This method open telnet connection with remote host and execute command.
# Params
# * hostname
# * ip
# * username
# * password
# * cmd (Command to be executed)
def test_telnet_connection_to(params = {})
  hostname = params[:hostname]
  ip = params[:ip]
  username = params[:username]
  password = params[:password]
  cmd = params[:cmd]
  output = []

  puts "\nTesting : " + params.to_s

  begin
      #h = Net::Telnet::new({ 'Host' => ip, 'Timeout' => 10, 'Prompt' => Regexp.new(username) })
      h = Net::Telnet::new({ 'Host' => ip, 'Timeout' => 10, 'Prompt' => /[$%#>]\s?\z/n })
      h.login(username, password)
      text = ''
      h.cmd(cmd) { |i| text << i }
      output=text.split("\n")
      h.close
  rescue Net::OpenTimeout
    puts(" ExceptionType=<Net::OpenTimeout> doing <telnet #{ip}>")
    puts(' └── Revise host IP!')
  rescue Net::ReadTimeout
    puts(" ExceptionType=<Net::ReadTimeout> doing <telnet #{ip}>")
  rescue Exception => e
    puts(" ExceptionType=<#{e.class}> doing telnet on <#{username}@#{ip}> exec: " + cmd)
    puts(" └── username=<#{username}>, password=<#{password}>, ip=<#{ip}>, HOSTID=<#{hostname}>")
  end

  puts "Output  : " + output.to_s
end

ip = '192.168.1.106'
test_telnet_connection_to(:ip => ip, :username => 'root', :password => 'profesor', :cmd => 'pwd')
test_telnet_connection_to(:ip => ip, :username => 'profesor', :password => 'profesor', :cmd => 'pwd')
test_telnet_connection_to(:ip => ip, :username => 'sysadmingame', :password => 'profesor', :cmd => 'pwd')
