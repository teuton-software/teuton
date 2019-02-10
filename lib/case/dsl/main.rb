# encoding: utf-8

module DSL

  def request(text)
    # do nothing
  end

  def command(pCommand, pArgs={})
    @action[:command] = pCommand
    tempfile(pArgs[:tempfile]) if pArgs[:tempfile]
  end

  #Set weight value for the action
  def weight(pValue=nil)
    if pValue.nil? then
      return @action[:weight]
    elsif pValue==:default then
      @action[:weight]=1.0
    else
      @action[:weight]=pValue.to_f
      end
  end

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
