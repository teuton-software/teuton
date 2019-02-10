# encoding: utf-8

module DSL

  #Read param pOption from [running, config or global] Hash data
  def get(pOption)
    @config.get(pOption)
  end

  def set( key, value)
    @config.set(key,value)
  end

end
