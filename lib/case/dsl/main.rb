
require_relative 'expect'
require_relative 'getset'
require_relative 'goto'
require_relative 'send'
require_relative 'target'

module DSL

  def log(pText="", pType=:info)
    s=""
    s=Rainbow("WARN!:").color(:yellow)+" " if pType==:warn
    s=Rainbow("ERROR:").bg(:red)+" " if pType==:error
    @report.lines << s+pText.to_s
  end

  alias_method :msg, :log

  def unique( key, value )
    return if value.nil?
    k=(key.to_s+"="+value.to_s).to_sym
    @uniques << k
  end

end
