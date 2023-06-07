require "net/ssh"
require "net/sftp"
require "rainbow"
require_relative "../../utils/project"
require_relative "../../utils/verbose"
require_relative "execute_base"

class CopySSH < ExecuteBase
  def call(host, localfilename)
    # Check params
    unless config.get("#{host}_route".to_sym) == "NODATA"
      log("'copy script' requires direct host access!", :error)
      return false
    end

    host = host.to_s

    begin
      if sessions[host].nil?
        # Open new SSH session
        ip = config.get("#{host}_ip".to_sym).to_s
        username = config.get("#{host}_username".to_sym).to_s
        password = config.get("#{host}_password".to_sym).to_s
        port = config.get("#{host}_port".to_sym).to_i
        port = 22 if port.zero?

        sessions[host] = Net::SSH.start(
          ip,
          username,
          port: port,
          password: password,
          keepalive: true,
          timeout: 30,
          non_interactive: true
        )
      end
      if sessions[host].instance_of? Net::SSH::Connection::Session
        copy_to(host, localfilename)
      else
        "SSH: NO CONNECTION!"
      end
    rescue => e
      sessions[host] = :nosession
      conn_status[host] = :error
      log("[#{e.class}] SSH on <#{username}@#{ip}>", :error)
    end
  end

  def copy_to(host, localfilename)
    ip = get((host + "_ip").to_sym)
    username = get((host + "_username").to_sym).to_s
    password = get((host + "_password").to_sym).to_s
    port = get((host + "_port").to_sym).to_i
    port = 22 if port.zero?

    localfilepath = File.join(Dir.pwd, localfilename)
    remotefilepath = File.join(".", File.basename(localfilename))

    # Upload a file or directory to the remote host
    begin
      Net::SFTP.start(ip, username, password: password, port: port) do |sftp|
        sftp.upload!(localfilepath, remotefilepath)
      end
    rescue
      log("copy file: #{localfilename} => #{remotefilepath}", :error)
      return false
    end
    true
  end
end
