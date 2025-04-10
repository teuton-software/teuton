require_relative "execute_local"
require_relative "execute_ssh"
require_relative "execute_telnet"

class ExecuteManager
  def initialize(parent)
    @parent = parent
    # READ: @config, cmd = action[:command]
    # WRITE: @action, @result, @session
    # my_execute, encode_and_split methods?
  end

  def call(host)
    start_time = Time.now
    run_on(host)
    action[:duration] = (Time.now - start_time).round(3)
  end

  private

  def action
    @parent.action
  end

  def config
    @parent.config
  end

  def log(...)
    @parent.log(...)
  end

  def run_on(host)
    protocol = config.get(:"#{host}_protocol")
    ip = config.get(:"#{host}_ip")

    if protocol.to_s.downcase == "local" || host.to_s == "localhost"
      # Protocol force => local
      ExecuteLocal.new(@parent).call
    elsif protocol.to_s.downcase == "ssh"
      # Protocol force => ssh
      ExecuteSSH.new(@parent).call(host)
    elsif protocol.to_s.downcase == "telnet"
      # Protocol force => telnet
      ExecuteTelnet.new(@parent).call(host)
    elsif ip.to_s.downcase == "localhost" || ip.to_s.include?("127.0.0.")
      # run_cmd_localhost
      ExecuteLocal.new(@parent).call
    elsif ip == "NODATA"
      log("#{host} IP not found!", :error)
    else
      # run_cmd_remote_ssh host
      ExecuteSSH.new(@parent).call(host)
    end
  end
end
