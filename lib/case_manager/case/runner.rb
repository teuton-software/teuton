
require 'net/ssh'
require 'net/sftp'
require 'net/telnet'

class Case

  private

  def run_local_cmd()
    @action[:conn_type]=:local
    @result.content = my_execute( @action[:command], @action[:encoding] )
  end

  def run_remote_cmd(pHostname)
    hostname = pHostname.to_s
    protocol = @config.get((hostname+'_protocol').to_sym) if @config.get((hostname+'_protocol').to_sym)
    protocol = :ssh if protocol.nil? or protocol=='NODATA'
    protocol = protocol.to_sym

    case protocol
    when :ssh
      run_remote_cmd_ssh(pHostname)
    when :telnet
      run_remote_cmd_telnet(pHostname)
    else
      raise "Unkown remote protocol <#{protocol.to_s}>"
    end
  end

  def run_remote_cmd_ssh(pHostname)
    @action[:conn_type] = :ssh
    app = Application.instance
    hostname = pHostname.to_s
    ip = @config.get((hostname+'_ip').to_sym)
    username = @config.get((hostname+'_username').to_sym).to_s
    password = @config.get((hostname+'_password').to_sym).to_s
    text = ''

    begin
      if @sessions[hostname].nil?
        @sessions[hostname] = Net::SSH.start(ip, username, :password => password)
      end

      if @sessions[hostname].class==Net::SSH::Connection::Session
        text = @sessions[hostname].exec!( @action[:command].to_s )
      end

    rescue Errno::EHOSTUNREACH
      @sessions[hostname]=:nosession
      verbose app.letter[:error]
      log( "Host #{ip} unreachable!", :error)
    rescue Net::SSH::AuthenticationFailed
      @sessions[hostname]=:nosession
      verbose app.letter[:error]
      log( "SSH::AuthenticationFailed!", :error)
    rescue Net::SSH::HostKeyMismatch
      @sessions[hostname]=:nosession
      verbose app.letter[:error]
      log('SSH::HostKeyMismatch!', :error)
      log("* The destination server's fingerprint is not matching what is in your local known_hosts file.",:error)
      log('* Remove the existing entry in your local known_hosts file', :error)
      log("* Try this => ssh-keygen -f '/home/USERNAME/.ssh/known_hosts' -R #{ip}", :error)
    rescue Exception => e
      @sessions[hostname] = :nosession
      verbose app.letter[:error]
      log( "[#{e.class}] SSH on <#{username}@#{ip}> exec: " + @action[:command], :error)
    end

    output = encode_and_split(@action[:encoding],text)

    @result.content = output
    @result.content.compact!
  end

  def run_remote_cmd_telnet(pHostname)
    @action[:conn_type] = :telnet
    app = Application.instance
    hostname = pHostname.to_s
    ip = @config.get((hostname+'_ip').to_sym)
    username = @config.get((hostname+'_username').to_sym).to_s
    password = @config.get((hostname+'_password').to_sym).to_s
    text = ''

    begin
      if @sessions[hostname].nil? || @sessions[hostname] == :ok
        #h = Net::Telnet::new({ 'Host' => ip, 'Timeout' => 10, 'Prompt' => /[$%#>]\s?\z/n })
        h = Net::Telnet::new( 'Host' => ip,
                              'Timeout' => 30,
                              'Prompt' => /login|teuton|[$%#>]/ )
#                               'Prompt' => Regexp.new(username[1,40]) })

        h.login(username, password)
        text = ''
        h.cmd(@action[:command]) { |i| text << i }
        h.close
        @sessions[hostname] = :ok
      end

    rescue Net::OpenTimeout
      @sessions[hostname] = :nosession
      verbose app.letter[:error]
      log(" ExceptionType=<Net::OpenTimeout> doing <telnet #{ip}>", :error)
      log(' └── Revise host IP!', :warn)
    rescue Net::ReadTimeout
      @sessions[hostname] = :nosession
      verbose app.letter[:error]
      log(" ExceptionType=<Net::ReadTimeout> doing <telnet #{ip}>", :error)
    rescue Exception => e
      @sessions[hostname] = :nosession
      verbose app.letter[:error]
      log(" ExceptionType=<#{e.class}> doing telnet on <#{username}@#{ip}> exec: " + @action[:command], :error)
      log(" └── username=<#{username}>, password=<#{password}>, ip=<#{ip}>, HOSTID=<#{hostname}>", :warn)
    end

    #@result.content = text.encode('UTF-8', :invalid => :replace).split("\n")
    output = encode_and_split(@action[:encoding], text)

    @result.content = output
    @result.content.compact!
  end
end
