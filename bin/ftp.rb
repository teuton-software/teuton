#!/usr/bin/env ruby

require 'net/ftp'

host = ARGV[0]
user = 'anonymous'
pass = 'anonymous'
filename = ARGV[1]

Net::FTP.open(host, user, pass) do |ftp|
  files = ftp.list
  puts "=> ftp> list"
  puts files

  content = ftp.get(filename)
end
