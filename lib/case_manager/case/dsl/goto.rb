# frozen_string_literal: true

require_relative '../runner'

# Case->DSL#goto
module DSL
  # Run command from the host identify as pHostname
  # goto :host1, :execute => "command"
  def goto(host = :localhost, args = {})
    @result.reset
    @action[:command] = args[:execute] if args[:execute]
    @action[:command] = args[:exec] if args[:exec]
    tempfile(args[:tempfile]) if args[:tempfile]
    @action[:encoding] = args[:encoding] || 'UTF-8'

    protocol = @config.get("#{host}_protocol".to_sym)
    ip = @config.get("#{host}_ip".to_sym)
    start_time = Time.now
    if (protocol == 'NODATA' || protocol.nil?) &&
       (host.to_s == 'localhost' || host.to_s.include?('127.0.0.') || ip.include?('127.0.0.'))
      run_local_cmd
    elsif ip == 'NODATA'
      log("#{host} IP not found!", :error)
    else
      run_remote_cmd host
    end
    @action[:duration] = (Time.now - start_time).round(3)
  end
  alias on goto

  def run(command, args = {})
    args[:exec] = command.to_s
    goto(:localhost, args)
  end
end
