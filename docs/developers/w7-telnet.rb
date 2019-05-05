#!/usr/bin/ruby
# encoding: utf-8

require 'net/telnet'

IP       = "192.168.1.111" #Enter the IP address here
USERNAME = "sysadmingame"  #Enter username here
PASSWORD = "profesor"      #Enter password here

h = Net::Telnet::new(	{	"Host" => IP,
                                "Timeout" => 30,
                                "Prompt" => /sysadmingame/
			})

h.login(USERNAME, PASSWORD)

# ver      => Windows , 6.1
# ipconfig => IPv4
# set      => computername=
# find cadena fichero
# type muestra fichero

command="ipconfig"

lines=[]
h.cmd(command) {|i| lines = i}
puts lines.class
l=lines.split("\n")
puts l.count

h.close

