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

  def guess_type(command)
    @command = command
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
    #binding.pry
    words = text.split
    words[0] = nil
    @name = :empty
    @desc = :empty
    unless words[1].nil?
      @name = words[1].downcase
      @desc = words.compact.join('_')
    end
  end
end


# 'lsb_release -d'
# 2231 => opensuse | openSUSE_Leap_15.3
# 2241 => debian   | Debian_GNU/Linux_10_(buster)
# 2242 => unkown UBUNTU!!!
# 2251 => manjaro  | Manjaro_Linux

ports = { win10: '2211', winserver: '2221',
          opensuse: '2231', debian: '2241', ubuntu: '2242',
          manjaro: '2251'}
osname = ARGV.first

if osname.nil?
  puts "Opciones : #{ports.keys.sort.join(', ').to_s}"
  exit 1
end
osname = osname.to_sym
remote_host = RemoteOS.new(ip: 'localhost',
                           port: ports[osname],
                           username: 'vagrant',
                           password: 'vagrant')

commands = { win10: 'hostname', winserver: 'hostname',
             opensuse: 'lsb_release -d', debian: 'lsb_release -d',
             ubuntu: 'lsb_release -d', manjaro: 'lsb_release -d'}

puts "[INFO] Trying with #{osname}..."
puts " * port    : #{ports[osname]}"
puts " * command : #{commands[osname]}"
puts ""
remote_host.guess_type(commands[osname])
remote_host.info
