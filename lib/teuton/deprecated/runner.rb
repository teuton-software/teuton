require "net/ssh"
require "net/sftp"
require "net/telnet"
require_relative "dsl/log"

class Case
  private

  # READ: @config
  # WRITE: @action, @result, @session
  def run_cmd_on(host)
    protocol = @config.get(:"#{host}_protocol")
    ip = @config.get(:"#{host}_ip")

    if protocol.to_s.downcase == "local" || host.to_s == "localhost"
      # Protocol force => local
      run_cmd_localhost
    elsif protocol.to_s.downcase == "ssh"
      # Protocol force => ssh
      run_cmd_remote_ssh(host)
    elsif protocol.to_s.downcase == "telnet"
      # Protocol force => telnet
      run_cmd_remote_telnet(host)
    elsif ip.to_s.downcase == "localhost" || ip.to_s.include?("127.0.0.")
      run_cmd_localhost
    elsif ip == "NODATA"
      log("#{host} IP not found!", :error)
    else
      run_cmd_remote_ssh host
    end
  end

  def run_cmd_localhost
    @action[:conn_type] = :local
    resp = my_execute(@action[:command], @action[:encoding])
    @result.exitcode = resp[:exitcode]
    @result.content = resp[:content]
  end

  def run_cmd_remote(input_hostname)
    # @param input_hostname (Symbol or String)
    hostname = input_hostname.to_s
    i = (hostname + "_protocol").to_sym
    protocol = @config.get(i) if @config.get(i)
    protocol = :ssh if protocol.nil? || protocol == "NODATA"
    protocol = protocol.to_sym
    case protocol
    when :ssh
      run_cmd_remote_ssh(input_hostname)
    when :telnet
      run_cmd_remote_telnet(input_hostname)
    when :local
      run_cmd_localhost
    else
      log("Protocol #{protocol} unknown! Use ssh or telnet.", :error)
    end
  end

  def run_cmd_remote_ssh(input_hostname)
    @action[:conn_type] = :ssh
    hostname = input_hostname.to_s
    ip = @config.get(:"#{hostname}_ip").to_s
    username = @config.get(:"#{hostname}_username").to_s
    password = @config.get(:"#{hostname}_password").to_s
    port = @config.get(:"#{hostname}_port").to_i
    port = 22 if port.zero?

    unless @config.get(:"#{hostname}_route") == "NODATA"
      # Reconfigure command with gateway. Example host1_route: IP.
      # hostname2 = hostname ¿not used?
      ip2 = ip
      username2 = username
      password2 = password
      command2 = @action[:command]
      hostname = @config.get(:"#{hostname}_route")
      ip = @config.get(:"#{hostname}_ip").to_s
      username = @config.get(:"#{hostname}_username").to_s
      password = @config.get(:"#{hostname}_password").to_s
      ostype = @config.get(:"#{hostname}_ostype").to_s

      @action[:command] = if ostype.downcase.start_with? "win"
        "echo y | plink #{username2}@#{ip2} -ssh -pw #{password2} \"#{command2}\""
      else
        "sshpass -p #{password2} #{username2}@#{ip2} #{command2}"
      end
    end

    text = ""
    exitcode = 0
    begin
      if @sessions[hostname].nil?
        @sessions[hostname] = Net::SSH.start(
          ip,
          username,
          port: port,
          password: password,
          keepalive: true,
          timeout: 30,
          non_interactive: true
        )
      end
      text = if @sessions[hostname].instance_of? Net::SSH::Connection::Session
        @sessions[hostname].exec!(@action[:command])
      else
        "SSH: NO CONNECTION!"
      end
      exitcode = text.exitstatus
    rescue Errno::EHOSTUNREACH
      @sessions[hostname] = :nosession
      @conn_status[hostname] = :host_unreachable
      exitcode = -1
      log("Host #{ip} unreachable!", :error)
    rescue Net::SSH::AuthenticationFailed
      @sessions[hostname] = :nosession
      @conn_status[hostname] = :error_authentication_failed
      exitcode = -1
      log("SSH::AuthenticationFailed!", :error)
    rescue Net::SSH::HostKeyMismatch
      @sessions[hostname] = :nosession
      @conn_status[hostname] = :host_key_mismatch
      exitcode = -1
      log("SSH::HostKeyMismatch!", :error)
      log("* The destination server's fingerprint is not matching " \
          "what is in your local known_hosts file.", :error)
      log("* Remove the existing entry in your local known_hosts file", :error)
      log("* Try this => ssh-keygen -f '/home/USERNAME/.ssh/known_hosts' " \
          "-R #{ip}", :error)
    rescue => e
      @sessions[hostname] = :nosession
      @conn_status[hostname] = :error
      exitcode = -1
      log("[#{e.class}] SSH on <#{username}@#{ip}>" \
          " exec: #{@action[:command]}", :error)
    end
    output = encode_and_split(@action[:encoding], text)
    @result.exitcode = exitcode
    @result.content = output
    @result.content.compact!
  end

  def run_cmd_remote_telnet(input_hostname)
    @action[:conn_type] = :telnet
    # app = Application.instance ¿not used?
    hostname = input_hostname.to_s
    ip = @config.get((hostname + "_ip").to_sym)
    username = @config.get((hostname + "_username").to_sym).to_s
    password = @config.get((hostname + "_password").to_sym).to_s
    text = ""
    begin
      if @sessions[hostname].nil? || @sessions[hostname] == :ok
        h = Net::Telnet.new(
          "Host" => ip,
          "Timeout" => 30,
          "Prompt" => /login|teuton|[$%#>]/
        )
        # "Prompt" => Regexp.new(username[1, 40]))
        # "Prompt" => /[$%#>] \z/n)
        h.login(username, password)
        h.cmd(@action[:command]) { |i| text << i }
        h.close
        @sessions[hostname] = :ok
      else
        text = "TELNET: NO CONNECTION!"
      end
    rescue Net::OpenTimeout
      @sessions[hostname] = :nosession
      @conn_status[hostname] = :open_timeout
      verbose Rainbow(Application.instance.letter[:error]).red.bright
      log(" ExceptionType=<Net::OpenTimeout> doing <telnet #{ip}>", :error)
      log(" └── Revise host IP!", :warn)
    rescue Net::ReadTimeout
      @sessions[hostname] = :nosession
      @conn_status[hostname] = :read_timeout
      verbose Rainbow(Application.instance.letter[:error]).red.bright
      log(" ExceptionType=<Net::ReadTimeout> doing <telnet #{ip}>", :error)
    rescue => e
      @sessions[hostname] = :nosession
      @conn_status[hostname] = :error
      verbose Rainbow(Application.instance.letter[:error]).red.bright
      log(" ExceptionType=<#{e.class}> doing telnet on <#{username}@#{ip}>" \
          " exec: #{@action[:command]}", :error)
      log(" └── username=<#{username}>, password=<#{password}>," \
          " ip=<#{ip}>, HOSTID=<#{hostname}>", :warn)
    end
    output = encode_and_split(@action[:encoding], text)
    @result.exitcode = -1
    @result.content = output
    @result.content.compact!
  end
end
