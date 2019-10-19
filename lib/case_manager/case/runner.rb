
require 'net/ssh'
require 'net/sftp'
require 'net/telnet'

# Class Case
# * run_local_cmd
# * run_remote_cmd
# * run_remote_cmd_ssh
# * run_remote_cmd_telnet
class Case

  private

  def run_local_cmd()
    @action[:conn_type] = :local
    i = my_execute( @action[:command], @action[:encoding] )
    @result.exitstatus = i[:exitstatus]
    @result.content = i[:content]
  end

  def run_remote_cmd(input_hostname)
    hostname = input_hostname.to_s
    i = (hostname + '_protocol').to_sym
    protocol = @config.get(i) if @config.get(i)
    protocol = :ssh if protocol.nil? || protocol == 'NODATA'
    protocol = protocol.to_sym
    case protocol
    when :ssh
      run_remote_cmd_ssh(input_hostname)
    when :telnet
      run_remote_cmd_telnet(input_hostname)
    else
      log("Protocol #{protocol} unknown! Use ssh or telnet.", :error)
    end
  end

  def run_remote_cmd_ssh(input_hostname)
    @action[:conn_type] = :ssh
    hostname = input_hostname.to_s
    ip = @config.get((hostname + '_ip').to_sym)
    username = @config.get((hostname + '_username').to_sym).to_s
    password = @config.get((hostname + '_password').to_sym).to_s
    text = ''
    begin
      if @sessions[hostname].nil?
        @sessions[hostname] = Net::SSH.start(ip,
                                             username,
                                             password: password,
                                             keepalive: true,
                                             non_interactive: true)
      end
      if @sessions[hostname].class == Net::SSH::Connection::Session
        text = @sessions[hostname].exec!(@action[:command].to_s)
      end
    rescue Errno::EHOSTUNREACH
      @sessions[hostname] = :nosession
      @conn_status[hostname] = :host_unreachable
      verbose Application.instance.letter[:error]
      log("Host #{ip} unreachable!", :error)
    rescue Net::SSH::AuthenticationFailed
      @sessions[hostname] = :nosession
      @conn_status[hostname] = :error_authentication_failed
      verbose Application.instance.letter[:error]
      log('SSH::AuthenticationFailed!', :error)
    rescue Net::SSH::HostKeyMismatch
      @sessions[hostname] = :nosession
      @conn_status[hostname] = :host_key_mismatch
      verbose Application.instance.letter[:error]
      log('SSH::HostKeyMismatch!', :error)
      log("* The destination server's fingerprint is not matching " \
          'what is in your local known_hosts file.', :error)
      log('* Remove the existing entry in your local known_hosts file', :error)
      log("* Try this => ssh-keygen -f '/home/USERNAME/.ssh/known_hosts' " \
          "-R #{ip}", :error)
    rescue StandardError => e
      @sessions[hostname] = :nosession
      @conn_status[hostname] = :error
      verbose Application.instance.letter[:error]
      log("[#{e.class}] SSH on <#{username}@#{ip}>" \
          " exec: #{@action[:command]}", :error)
    end
    output = encode_and_split(@action[:encoding], text)
    @result.content = output
    @result.content.compact!
  end

  def run_remote_cmd_telnet(input_hostname)
    @action[:conn_type] = :telnet
    app = Application.instance
    hostname = input_hostname.to_s
    ip = @config.get((hostname + '_ip').to_sym)
    username = @config.get((hostname + '_username').to_sym).to_s
    password = @config.get((hostname + '_password').to_sym).to_s
    text = ''
    begin
      if @sessions[hostname].nil? || @sessions[hostname] == :ok
        h = Net::Telnet.new( 'Host' => ip,
                             'Timeout' => 30,
                             'Prompt' => /login|teuton|[$%#>]/ )
#                            'Prompt' => Regexp.new(username[1, 40]))
#                            'Prompt' => /[$%#>] \z/n)
        h.login(username, password)
        text = ''
        h.cmd(@action[:command]) { |i| text << i }
        h.close
        @sessions[hostname] = :ok
      end
    rescue Net::OpenTimeout
      @sessions[hostname] = :nosession
      @conn_status[hostname] = :open_timeout
      verbose Application.instance.letter[:error]
      log(" ExceptionType=<Net::OpenTimeout> doing <telnet #{ip}>", :error)
      log(' └── Revise host IP!', :warn)
    rescue Net::ReadTimeout
      @sessions[hostname] = :nosession
      @conn_status[hostname] = :read_timeout
      verbose Application.instance.letter[:error]
      log(" ExceptionType=<Net::ReadTimeout> doing <telnet #{ip}>", :error)
    rescue StandardError => e
      @sessions[hostname] = :nosession
      @conn_status[hostname] = :error
      verbose Application.instance.letter[:error]
      log(" ExceptionType=<#{e.class}> doing telnet on <#{username}@#{ip}>" \
          " exec: #{@action[:command]}", :error)
      log(" └── username=<#{username}>, password=<#{password}>," \
          " ip=<#{ip}>, HOSTID=<#{hostname}>", :warn)
    end
    output = encode_and_split(@action[:encoding], text)
    @result.content = output
    @result.content.compact!
  end
end
