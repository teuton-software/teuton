#!/usr/bin/env ruby

require 'pry-byebug'
require 'net/ssh'
require 'net/telnet'

class RemoteOS
  attr_reader :type


  def initialize(args)
    @ip = args[:ip] || 'localhost'
    @port = args[:port] || '22'
    @username = args[:username] || 'root'
    @password =  args[:password] || 'vagrant'
    @type = :unkown
    @command = 'lsb_release -d'
  end

  def info
    puts "[INFO] RemoteOS"
    puts " * ip       : #{@ip}"
    puts " * port     : #{@port}"
    puts " * username : #{@username}"
    puts " * password : #{@password}"
    puts " * type     : #{@type}"
    puts " * command  : #{@command}"
  end

  def guess_type
    text = ''
    begin
      session = Net::SSH.start(@ip,
                               @username,
                               port: @port,
                               password: @password,
                               keepalive: true,
                               timeout: 30,
                               non_interactive: true)
      if session.class == Net::SSH::Connection::Session
        text = session.exec!(@command)
      end
    rescue Errno::EHOSTUNREACH
      puts ("[ERROR] Host #{@ip} unreachable!")
    rescue Net::SSH::AuthenticationFailed
      puts('[ERROR] SSH::AuthenticationFailed!')
    rescue Net::SSH::HostKeyMismatch
      puts('SSH::HostKeyMismatch!')
      puts("* The destination server's fingerprint is not matching " \
          'what is in your local known_hosts file.')
      puts('* Remove the existing entry in your local known_hosts file')
      puts("* Try this => ssh-keygen -f '/home/USERNAME/.ssh/known_hosts' " \
          "-R #{@ip}")
    rescue StandardError => e
      puts("[#{e.class}] SSH on <#{@username}@#{@ip}>" \
          " exec: #{@command}")
    end
    #@result.exitstatus = text.exitstatus
    #[text, text.exitstatus]
    words = text.split
    words[0] = nil
    @type = words.compact.join('_')
  end
end

h = RemoteOS.new(ip: 'localhost',
                 port: '2222',
                 username: 'vagrant',
                 password: 'vagrant')

h.guess_type
h.info

# 'lsb_release -d'
# => Debian_GNU/Linux_10_(buster)
