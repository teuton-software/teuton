# frozen_string_literal: true

# DSL#log
module DSL
  def log(text = '', type = :info)
    s = ''
    s = Rainbow('WARN!').color(:yellow) if type == :warn
    s = Rainbow('ERROR').bg(:red) if type == :error
    t = Time.now
    f = format('%02d:%02d:%02d', t.hour, t.min, t.sec)
    @report.lines << "[#{f}] #{s}: #{text}"
  end
  alias msg log
end
