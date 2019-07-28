# frozen_string_literal: true

require 'net/ssh'

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

    start_time = Time.now
    if host.to_s == 'localhost' || host.to_s.include?('127.0.0.')
      run_local_cmd
    else
      ip = get((host.to_s + '_ip').to_sym)
      if ip.nil?
        log("#{host} IP is nil!", :error)
      elsif ip.include?('127.0.0.')
        run_local_cmd
      else
        run_remote_cmd host
      end
    end
    @action[:duration] = (Time.now - start_time).round(3)
  end
  alias on goto

  def run(command, args = {})
    args[:exec] = command.to_s
    goto(:localhost, args)
  end
end
