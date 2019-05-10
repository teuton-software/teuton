# DSL#log
module DSL
  def log(text = '', type = :info)
    s = ''
    s = Rainbow('WARN!:').color(:yellow) + ' ' if type == :warn
    s = Rainbow('ERROR:').bg(:red) + ' ' if type == :error
    @report.lines << s + text.to_s
  end
  alias msg log
end
