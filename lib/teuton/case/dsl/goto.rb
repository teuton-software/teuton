# frozen_string_literal: true

require_relative "../execute_manager"

module DSL
  ##
  # DSL run and goto
  # run: It's the same as goto :localhost
  # @param command (String)
  # @param args (Hash)
  def run(command, args = {})
    args[:exec] = command.to_s
    host = :localhost
    host = args[:on] if args[:on]
    goto(host, args)
  end

  # Run command from the host identify as "host"
  # goto :host1, :execute => "command"
  def goto(host = :localhost, args = {})
    @result.reset
    args[:on] = host unless args[:on]
    @action[:command] = args[:execute].to_s if args[:execute]
    @action[:command] = args[:exec].to_s if args[:exec]
    tempfile(args[:tempfile]) if args[:tempfile]
    @action[:encoding] = args[:encoding] || "UTF-8"

    # start_time = Time.now
    ExecuteManager.new(self).run_cmd_on(host)
    # @action[:duration] = (Time.now - start_time).round(3)
  end
  alias_method :on, :goto
end
