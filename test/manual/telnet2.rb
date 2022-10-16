#!/usr/bin/env ruby

require "net/telnet"

def test_telnet_connection_to(params = {})
  hostname = params[:hostname]
  ip = params[:ip]
  username = params[:username]
  password = params[:password]
  cmd = params[:cmd]
  output = []

  puts "\nTesting : " + params.to_s

  begin
    h = Net::Telnet.new({"Host" => ip, "Timeout" => 40, "Prompt" => Regexp.new(username)})
    h.login(username, password)
    text = ""
    h.cmd(cmd) { |i| text << i }
    output = text.split("\n")
    h.close
  rescue Net::OpenTimeout
    puts(" ExceptionType=<Net::OpenTimeout> doing <telnet #{ip}>")
    puts(" └── Revise host IP!")
  rescue Net::ReadTimeout
    puts(" ExceptionType=<Net::ReadTimeout> doing <telnet #{ip}>")
  rescue StardardError => e
    puts(" ExceptionType=<#{e.class}> doing telnet on <#{username}@#{ip}> exec: " + cmd)
    puts(" └── username=<#{username}>, password=<#{password}>, ip=<#{ip}>, HOSTID=<#{hostname}>")
  end

  puts "Output  : " + output.to_s
end

test_telnet_connection_to(ip: "192.168.1.100", username: "root",
  password: "profesor", cmd: "pwd")
test_telnet_connection_to(ip: "192.168.1.106", username: "profesor",
  password: "profesor", cmd: "pwd")
test_telnet_connection_to(ip: "192.168.1.106", username: "sysadmingame",
  password: "sysadmingame", cmd: "pwd")
