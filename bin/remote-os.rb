
require 'net/ssh'
require 'net/telnet'

class RemoteOS
  attr_reader :type

  def initialize(args)
    @host_ip = args[:ip] || 'localhost'
    @host_port = args[:port] || '22'
    @host_username = args[:username] || 'root'
    @host_password =  args[:password] || 'vagrant'
    @type = :unkown
  end

  private

  def quess_type
    command = 'lsb_release -d'
    text = ''
    begin
      session = Net::SSH.start(@host_ip,
                               @host_username,
                               port: @host_port,
                               password: @host_password,
                               keepalive: true,
                               timeout: 30,
                               non_interactive: true)
      end
      if session.class == Net::SSH::Connection::Session
        text = @session.exec!(command)
      end
    rescue Errno::EHOSTUNREACH
      puts ("[ERROR] Host #{@host_ip} unreachable!")
    rescue Net::SSH::AuthenticationFailed
      puts('[ERROR] SSH::AuthenticationFailed!')
    rescue Net::SSH::HostKeyMismatch
      puts('SSH::HostKeyMismatch!')
      puts("* The destination server's fingerprint is not matching " \
          'what is in your local known_hosts file.')
      puts('* Remove the existing entry in your local known_hosts file')
      puts("* Try this => ssh-keygen -f '/home/USERNAME/.ssh/known_hosts' " \
          "-R #{@host_ip}")
    rescue StandardError => e
      puts("[#{e.class}] SSH on <#{@host_username}@#{@host_ip}>" \
          " exec: #{command}")
    end
    @result.exitstatus = text.exitstatus
    [text, text.exitstatus]
  end

end
