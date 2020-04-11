# frozen_string_literal: true

require_relative '../runner'

# Case class -> DSL module:
# * goto
# * run
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
    run_cmd_on(host)
    @action[:duration] = (Time.now - start_time).round(3)
  end
  alias on goto

  ##
  # DLS run: It's the same as goto :localhost
  # @param command (String)
  # @param args (Hash)
  def run(command, args = {})
    args[:exec] = command.to_s
    host = :localhost
    host = args[:into] if args[:into] # TO-FIX
    goto(host, args)
  end
end
