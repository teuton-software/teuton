require "net/ssh"
require "net/sftp"
require "net/telnet"
require "open3"
require "rainbow"
require_relative "../../utils/project"
require_relative "../../utils/verbose"
require_relative "execute_local"
require_relative "execute_telnet"

class ExecuteManager
  include Verbose

  def initialize(parent)
    @parent = parent
    # READ: @config, cmd = action[:command]
    # WRITE: @action, @result, @session
    # my_execute, encode_and_split methods?
  end

  def run_cmd_on(host)
    start_time = Time.now

    protocol = config.get("#{host}_protocol".to_sym)
    ip = config.get("#{host}_ip".to_sym)

    if protocol.to_s.downcase == "local" || host.to_s == "localhost"
      # Protocol force => local
      # run_cmd_localhost
      ExecuteLocal.new(@parent).call
    elsif protocol.to_s.downcase == "ssh"
      # Protocol force => ssh
      run_cmd_remote_ssh(host)
    elsif protocol.to_s.downcase == "telnet"
      # Protocol force => telnet
      # run_cmd_remote_telnet(host)
      ExecuteTelnet.new(@parent).call(host)
    elsif ip.to_s.downcase == "localhost" || ip.to_s.include?("127.0.0.")
      # run_cmd_localhost
      ExecuteLocal.new(@parent).call
    elsif ip == "NODATA"
      log("#{host} IP not found!", :error)
    else
      run_cmd_remote_ssh host
    end

    action[:duration] = (Time.now - start_time).round(3)
  end

  private

  def config
    @parent.config
  end

  def action
    @parent.action
  end

  def result
    @parent.result
  end

  def sessions
    @parent.sessions
  end

  def log(...)
    @parent.log(...)
  end

  def conn_status
    @parent.conn_status
  end

  def run_cmd_remote(input_hostname)
    hostname = input_hostname.to_s # input_hostname could by Symbol or String
    i = (hostname + "_protocol").to_sym
    protocol = config.get(i) if config.get(i)
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
    action[:conn_type] = :ssh
    hostname = input_hostname.to_s
    ip = config.get("#{hostname}_ip".to_sym).to_s
    username = config.get("#{hostname}_username".to_sym).to_s
    password = config.get("#{hostname}_password".to_sym).to_s
    port = config.get("#{hostname}_port".to_sym).to_i
    port = 22 if port.zero?

    unless config.get("#{hostname}_route".to_sym) == "NODATA"
      # Reconfigure command with gateway. Example host1_route: IP.
      # hostname2 = hostname ¿not used?
      ip2 = ip
      username2 = username
      password2 = password
      command2 = action[:command]
      hostname = config.get("#{hostname}_route".to_sym)
      ip = config.get("#{hostname}_ip".to_sym).to_s
      username = config.get("#{hostname}_username".to_sym).to_s
      password = config.get("#{hostname}_password".to_sym).to_s
      ostype = config.get("#{hostname}_ostype".to_sym).to_s

      action[:command] = if ostype.downcase.start_with? "win"
        "echo y | plink #{username2}@#{ip2} -ssh -pw #{password2} \"#{command2}\""
      else
        "sshpass -p #{password2} #{username2}@#{ip2} #{command2}"
      end
    end

    text = ""
    exitcode = 0
    begin
      if sessions[hostname].nil?
        sessions[hostname] = Net::SSH.start(
          ip,
          username,
          port: port,
          password: password,
          keepalive: true,
          timeout: 30,
          non_interactive: true
        )
      end
      text = if sessions[hostname].instance_of? Net::SSH::Connection::Session
        sessions[hostname].exec!(action[:command])
      else
        "SSH: NO CONNECTION!"
      end
      exitcode = text.exitstatus
    rescue Errno::EHOSTUNREACH
      sessions[hostname] = :nosession
      conn_status[hostname] = :host_unreachable
      exitcode = -1
      log("Host #{ip} unreachable!", :error)
    rescue Net::SSH::AuthenticationFailed
      sessions[hostname] = :nosession
      conn_status[hostname] = :error_authentication_failed
      exitcode = -1
      log("SSH::AuthenticationFailed!", :error)
    rescue Net::SSH::HostKeyMismatch
      sessions[hostname] = :nosession
      conn_status[hostname] = :host_key_mismatch
      exitcode = -1
      log("SSH::HostKeyMismatch!", :error)
      log("* The destination server's fingerprint is not matching " \
          "what is in your local known_hosts file.", :error)
      log("* Remove the existing entry in your local known_hosts file", :error)
      log("* Try this => ssh-keygen -f '/home/USERNAME/.ssh/known_hosts' " \
          "-R #{ip}", :error)
    rescue => e
      sessions[hostname] = :nosession
      conn_status[hostname] = :error
      exitcode = -1
      log("[#{e.class}] SSH on <#{username}@#{ip}>" \
          " exec: #{action[:command]}", :error)
    end
    output = encode_and_split(action[:encoding], text)
    result.exitcode = exitcode
    result.content = output
    result.content.compact!
  end

  def encode_and_split(encoding, text)
    # Convert text to UTF-8 deleting unknown chars
    text ||= "" # Ensure text is not nil
    flag = [:default, "UTF-8"].include? encoding
    return text.encode("UTF-8", invalid: :replace).split("\n") if flag

    # Convert text from input ENCODING to UTF-8
    ec = Encoding::Converter.new(encoding.to_s, "UTF-8")
    begin
      text = ec.convert(text)
    rescue => e
      puts "[ERROR] #{e}: Declare text encoding..."
      puts "        run 'command', on: :host, :encoding => 'ISO-8859-1'"
    end

    text.split("\n")
  end
end
