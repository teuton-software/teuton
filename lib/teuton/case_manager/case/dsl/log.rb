# frozen_string_literal: true

##
# Case class -> DSL module : log function
module DSL
  ##
  # Record log message
  # @param text (String)
  # @param type (Symbol) Values :info, :warn or :error
  def log(text = '', type = :info)
    s = ''
    s = Rainbow('WARN!').color(:yellow) if type == :warn
    s = Rainbow('ERROR').bg(:red) if type == :error
    t = Time.now
    f = format('%<hour>02d:%<min>02d:%<sec>02d',
               { hour: t.hour, min: t.min, sec: t.sec })
    @report.lines << "[#{f}] #{s}: #{text}"
  end
  alias msg log
end
