require "net/ssh"
require "net/sftp"
require "rainbow"
require_relative "../../utils/project"
# require_relative "../../utils/verbose"
require_relative "execute_base"

class ExecuteSSH < ExecuteBase
  def call(input_hostname)
    action[:conn_type] = :ssh
    hostname = input_hostname.to_s
    ip = config.get(:"#{hostname}_ip").to_s
    username = config.get(:"#{hostname}_username").to_s
    password = config.get(:"#{hostname}_password").to_s
    port = config.get(:"#{hostname}_port").to_i
    port = 22 if port.zero?

    unless config.get(:"#{hostname}_route") == "NODATA"
      # Reconfigure command with gateway. Example host1_route: IP.
      # hostname2 = hostname ¿not used?
      ip2 = ip
      username2 = username
      password2 = password
      command2 = action[:command]
      hostname = config.get(:"#{hostname}_route")
      ip = config.get(:"#{hostname}_ip").to_s
      username = config.get(:"#{hostname}_username").to_s
      password = config.get(:"#{hostname}_password").to_s
      ostype = config.get(:"#{hostname}_ostype").to_s

      action[:command] = if ostype.downcase.start_with? "win"
        "echo y | plink #{username2}@#{ip2} -ssh -pw #{password2} \"#{command2}\""
      else
        "sshpass -p #{password2} #{username2}@#{ip2} #{command2}"
      end
    end

    text = "TEUTON_NODATA"
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
      if sessions[hostname].instance_of? Net::SSH::Connection::Session
        text = sessions[hostname].exec!(action[:command])
        exitcode = text.exitstatus
      else
        text = "TEUTON_ERROR_SSH_NO_CONNECTION"
        exitcode = -1
      end
    rescue Errno::EHOSTUNREACH
      sessions[hostname] = :nosession
      conn_status[hostname] = :host_unreachable
      text = "TEUTON_ERROR_SSH_HOST_UNREACHABLE"
      exitcode = -1
      log("Host #{ip} unreachable!", :error)
    rescue Net::SSH::AuthenticationFailed
      sessions[hostname] = :nosession
      conn_status[hostname] = :error_authentication_failed
      text = "TEUTON_ERROR_SSH_AUTH_FAILED"
      exitcode = -1
      log("SSH::AuthenticationFailed!", :error)
    rescue Net::SSH::HostKeyMismatch
      sessions[hostname] = :nosession
      conn_status[hostname] = :host_key_mismatch
      text = "TEUTON_ERROR_SSH_HOST_KEY"
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
      text = "TEUTON_ERROR_SSH"
      exitcode = -1
      log("[#{e.class}] SSH on <#{username}@#{ip}>" \
          " exec: #{action[:command]}", :error)
    end
    result.exitcode = exitcode
    result.content = encode_and_split(action[:encoding], text)
  end
end
