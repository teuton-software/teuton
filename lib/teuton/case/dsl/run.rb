# frozen_string_literal: true

require_relative "../execute/execute_manager"

module DSL
  ##
  # DSL run
  # @param command (String)
  # @param args (Hash)
  def run(command, args = {})
    @action.command = command.to_s
    @action.host = args[:on] || :localhost
    @action.encoding = args[:encoding] || "UTF-8"

    @result.reset

    ExecuteManager.new(self).call(@action.host)
    @action.output = if @result.content.size < 2
                       @result.value.clone
                     else
                       "(#{@result.content.size} lines)"
                     end
  end

  def goto(...)
    Logger.warn "Keyword DSL deprecated! <goto>"
    run(...)
  end
end
