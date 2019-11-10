# frozen_string_literal: true

# DSL#request, DSL#target2
module DSL
  def request(text)
    raise "Deprecated request #{text}"
    # do nothing by now
  end

  def command(p_command, args = {})
    @action[:command] = p_command
    tempfile(args[:tempfile]) if args[:tempfile]
  end
end
