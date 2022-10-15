#!/usr/bin/env ruby

# load gem to use ssh tool
require "net/ssh"

# This method open ssh connection with remote host and execute command.
# Params
# * hostname
# * ip
# * username
# * password
# * cmd (Command to be executed)
def ssh_to(params = {})
  _hostname = params[:hostname]
  ip = params[:ip]
  username = params[:username]
  password = params[:password]
  cmd = params[:cmd]
  output = []

  puts "\nTesting : " + params.to_s

  begin
    h = Net::SSH.start(ip, username, password: password)
    text = h.exec!(cmd)
    output = text.split("\n")
  rescue Errno::EHOSTUNREACH
    puts("Host #{ip} unreachable!")
  rescue Net::SSH::AuthenticationFailed
    puts("SSH::AuthenticationFailed!")
  rescue Net::SSH::HostKeyMismatch
    puts("SSH::HostKeyMismatch!")
    puts("* The destination server's fingerprint is not matching what is in your local known_hosts file.")
    puts("* Remove the existing entry in your local known_hosts file")
    puts("* Try this => ssh-keygen -f '/home/USERNAME/.ssh/known_hosts' -R #{ip}")
  rescue => e
    puts("[#{e.class}] SSH on <#{username}@#{ip}> exec: " + cmd)
    puts e
  end

  puts "Output  : " + output.to_s
end

def connect_to_debian9
  ip = "192.168.1.106"
  ssh_to(ip: ip, username: "root", password: "profesor", cmd: "whoami")
  ssh_to(ip: ip, username: "profesor", password: "profesor", cmd: "whoami")
end

def connect_to_win2008
  ip = "192.168.1.115"
  ssh_to(ip: ip, username: "Administrador", password: "profesorFP2018", cmd: "whoami")
  ssh_to(ip: ip, username: "profesor", password: "sayonaraBABY2018", cmd: "whoami")
end

def connect_to_win2012
  ip = "192.168.1.114"
  ssh_to(ip: ip, username: "Administrador", password: "profesorFP2018", cmd: "whoami")
  ssh_to(ip: ip, username: "profesor", password: "sayonaraBABY2018", cmd: "whoami")
  ssh_to(ip: ip, username: "Administrador", password: "profesorFP2018", cmd: "get-windowsfeature -name rds-rd-server")
end

connect_to_win2012
