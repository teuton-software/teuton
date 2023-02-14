#!/usr/bin/env ruby

require 'net/ftp'

host = ARGV[0]
user = 'anonymous'
pass = 'anonymous'
filename = ARGV[1]

begin
  ftp = Net::FTP.open(host, user, pass)
  files = ftp.list
  puts "[ INFO ] list:"
  puts files

  puts "[ INFO ] get #{filename}"
  ftp.get(filename, "localfile-#{filename}")

  ftp.close
rescue Errno::EHOSTUNREACH
  puts "[ ERROR ] Host unreacheble!"
rescue Net::FTPPermError
  puts "[ ERROR ] 550 Failed to open file!"
  puts "          OR  Login error!"
end
