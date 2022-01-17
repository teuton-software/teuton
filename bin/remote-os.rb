#!/usr/bin/env ruby

require 'pry-byebug'
require 'net/ssh'
require 'net/telnet'

class RemoteOS
  attr_reader :name, :desc
  attr_accessor :command

  def initialize(args)
    @ip = args[:ip] || 'localhost'
    @port = args[:port] || '22'
    @username = args[:username] || 'root'
    @password =  args[:password] || 'vagrant'
    @desc = :unkown
    @name = :unkown
    @command = 'lsb_release -d'
  end

  def info
    puts "[INFO] RemoteOS"
    puts " * ip       : #{@ip}"
    puts " * port     : #{@port}"
    puts " * username : #{@username}"
    puts " * password : #{@password}"
    puts " * desc     : #{@desc}"
    puts " * name     : #{@name}"
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
    @name = words[1].downcase
    @desc = words.compact.join('_')
  end
end

h = RemoteOS.new(ip: 'localhost',
                 port: '2231',
                 username: 'vagrant',
                 password: 'vagrant')

h.guess_type
h.info

# 'lsb_release -d'
# 2231 => opensuse | openSUSE_Leap_15.3
# 2241 => debian   | Debian_GNU/Linux_10_(buster)
# 2251 => manjaro  | Manjaro_Linux
