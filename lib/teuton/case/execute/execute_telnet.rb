require "net/telnet"
# require "rainbow"
require_relative "../../utils/project"
# require_relative "../../utils/verbose"
require_relative "execute_base"

class ExecuteTelnet < ExecuteBase
  def call(input_hostname)
    action[:conn_type] = :telnet
    hostname = input_hostname.to_s
    ip = config.get((hostname + "_ip").to_sym)
    port = config.get((hostname + "_port").to_sym)
    mode = true
    if port.to_i == 0
      port = "23" 
      mode = false
    end
    text = ""
    exitcode = -1
    begin
      if sessions[hostname].nil? || sessions[hostname] == :ok
        h = Net::Telnet.new(
          "Host" => ip,
          "Port" => port,
          "Telnetmode" => mode,
          "Timeout" => 30,
          "Prompt" => /login|teuton|[$%#>]/
        )
        # "Prompt" => Regexp.new(username[1, 40]))
        # "Prompt" => /[$%#>] \z/n)
        unless mode
          username = config.get((hostname + "_username").to_sym).to_s
          password = config.get((hostname + "_password").to_sym).to_s
          h.login(username, password)
        end
        h.cmd(action[:command]) { |i| text << i }
        h.close
        sessions[hostname] = :ok
        exitcode = 0
      else
        text = "Telnet: NO CONNECTION!"
      end
    rescue Net::OpenTimeout
      sessions[hostname] = :nosession
      conn_status[hostname] = :open_timeout
      log(" ExceptionType=<Net::OpenTimeout> doing <telnet #{ip}>", :error)
      log(" └── Revise host IP!", :warn)
    rescue Net::ReadTimeout
      sessions[hostname] = :nosession
      conn_status[hostname] = :read_timeout
      log(" ExceptionType=<Net::ReadTimeout> doing <telnet #{ip}>", :error)
    rescue => e
      sessions[hostname] = :nosession
      conn_status[hostname] = :error
      log(" ExceptionType=<#{e.class}> doing telnet on <#{username}@#{ip}>" \
          " exec: #{action[:command]}", :error)
      log(" └── username=<#{username}>, password=<#{password}>," \
          " ip=<#{ip}>, HOSTID=<#{hostname}>", :warn)
    end
    result.exitcode = exitcode
    result.content = encode_and_split(action[:encoding], text)
  end
end
