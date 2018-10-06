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
def telnet_to(params = {})
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

def connect_to_debian9
  ip = '192.168.1.106'
  telnet_to(:ip => ip, :username => 'root', :password => 'profesor', :cmd => 'whoami')
  telnet_to(:ip => ip, :username => 'profesor', :password => 'profesor', :cmd => 'whoami')
end

def connect_to_win2008
  ip = '192.168.1.115'
  telnet_to(:ip => ip, :username => 'Administrador', :password => 'profesorFP2018', :cmd => 'whoami')
  telnet_to(:ip => ip, :username => 'profesor', :password => 'sayonaraBABY2018', :cmd => 'whoami')
end

def connect_to_win2012
  ip = '192.168.1.114'
  telnet_to(:ip => ip, :username => 'Administrador', :password => 'profesorFP2018', :cmd => 'whoami')
  telnet_to(:ip => ip, :username => 'profesor', :password => 'sayonaraBABY2018', :cmd => 'whoami')
end

connect_to_win2012
