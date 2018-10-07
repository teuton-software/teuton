#!/usr/bin/ruby

# This method open ssh connection with remote host and execute command.
# Params
# * hostname
# * ip
# * username
# * password
# * cmd (Command to be executed)
def exec_to(params = {})
  hostname = params[:hostname]
  ip = params[:ip]
  username = params[:username]
  password = params[:password]
  cmd = params[:cmd]
  output = []

  puts "\nTesting : " + params.to_s

  ec = Encoding::Converter.new("ISO-8859-1","UTF-8")
  raw = "sshpass -p #{password} ssh #{username}@#{ip} #{cmd}"
  text1 = `#{raw}`
  text = ec.convert(text1)
  output = text.to_s.split("\n")

  puts "Output  : " + output.to_s
end

def connect_to_debian9
  ip = '192.168.1.106'
  exec_to(:ip => ip, :username => 'root', :password => 'profesor', :cmd => 'whoami')
  exec_to(:ip => ip, :username => 'profesor', :password => 'profesor', :cmd => 'whoami')
end

def connect_to_win2008
  ip = '192.168.1.115'
  exec_to(:ip => ip, :username => 'Administrador', :password => 'profesorFP2018', :cmd => 'whoami')
  exec_to(:ip => ip, :username => 'profesor', :password => 'sayonaraBABY2018', :cmd => 'whoami')
end

def connect_to_win2012
  ip = '192.168.1.114'
  exec_to(:ip => ip, :username => 'Administrador', :password => 'profesorFP2018', :cmd => 'whoami')
  exec_to(:ip => ip, :username => 'profesor', :password => 'sayonaraBABY2018', :cmd => 'whoami')
  exec_to(:ip => ip, :username => 'Administrador', :password => 'profesorFP2018', :cmd => 'get-windowsfeature -name rds-rd-server')
end

connect_to_win2012
