# frozen_string_literal: true

##
# Case class -> DSL module : log function
module DSL
  ##
  # Record log message
  # @param text (String)
  # @param type (Symbol) Values :info, :warn or :error
  # rubocop:disable Style/FormatStringToken
  def log(text = '', type = :info)
    s = ''
    s = Rainbow('WARN!').color(:yellow) if type == :warn
    s = Rainbow('ERROR').bg(:red) if type == :error
    t = Time.now
#    f = format('%02d:%02d:%02d', t.hour, t.min, t.sec)
    f = '%02d:%02d:%02d' % [t.hour, t.min, t.sec]
    @report.lines << "[#{f}] #{s}: #{text}"
  end
  # rubocop:enable Style/FormatStringToken
  alias msg log
end
