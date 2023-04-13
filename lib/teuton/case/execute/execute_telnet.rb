require "net/telnet"
require "rainbow"
require_relative "../../utils/project"
require_relative "../../utils/verbose"
require_relative "execute_base"

class ExecuteTelnet < ExecuteBase
  def call(input_hostname)
    action[:conn_type] = :telnet
    hostname = input_hostname.to_s
    ip = config.get((hostname + "_ip").to_sym)
    username = config.get((hostname + "_username").to_sym).to_s
    password = config.get((hostname + "_password").to_sym).to_s
    text = ""
    begin
      if sessions[hostname].nil? || sessions[hostname] == :ok
        h = Net::Telnet.new(
          "Host" => ip,
          "Timeout" => 30,
          "Prompt" => /login|teuton|[$%#>]/
        )
        # "Prompt" => Regexp.new(username[1, 40]))
        # "Prompt" => /[$%#>] \z/n)
        h.login(username, password)
        h.cmd(action[:command]) { |i| text << i }
        h.close
        sessions[hostname] = :ok
      else
        text = "TELNET: NO CONNECTION!"
      end
    rescue Net::OpenTimeout
      sessions[hostname] = :nosession
      conn_status[hostname] = :open_timeout
      verbose Rainbow(Application.instance.letter[:error]).red.bright
      log(" ExceptionType=<Net::OpenTimeout> doing <telnet #{ip}>", :error)
      log(" └── Revise host IP!", :warn)
    rescue Net::ReadTimeout
      sessions[hostname] = :nosession
      conn_status[hostname] = :read_timeout
      verbose Rainbow(Application.instance.letter[:error]).red.bright
      log(" ExceptionType=<Net::ReadTimeout> doing <telnet #{ip}>", :error)
    rescue => e
      sessions[hostname] = :nosession
      conn_status[hostname] = :error
      verbose Rainbow(Application.instance.letter[:error]).red.bright
      log(" ExceptionType=<#{e.class}> doing telnet on <#{username}@#{ip}>" \
          " exec: #{action[:command]}", :error)
      log(" └── username=<#{username}>, password=<#{password}>," \
          " ip=<#{ip}>, HOSTID=<#{hostname}>", :warn)
    end
    output = encode_and_split(action[:encoding], text)
    result.exitcode = -1
    result.content = output
    result.content.compact!
  end
end
