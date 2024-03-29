module CheckDSL
  def get(varname)
    data = @stats[:gets]
    data[varname] = data[varname] ? (data[varname] + 1) : 1
    "get(#{varname})"
  end

  def gett(option)
    get(option)
  end

  def set(key, value)
    key = ":" + key.to_s if key.instance_of? Symbol
    value = ":" + value.to_s if value.instance_of? Symbol

    @stats[:sets] << "#{key}=#{value}"
    Logger.info "      set(#{key},#{value})"
  end

  def unset(key)
    Logger.info "      unset(#{key})"
  end
end
