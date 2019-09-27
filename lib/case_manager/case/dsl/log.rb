# frozen_string_literal: true

# DSL#log
module DSL
  def log(text = '', type = :info)
    s = ''
    s = Rainbow('WARN!').color(:yellow) if type == :warn
    s = Rainbow('ERROR').bg(:red) if type == :error
    t = Time.now
    @report.lines << "[#{t.hour}:#{t.min}:#{t.sec}] #{s}: #{text}"
  end
  alias msg log
end
