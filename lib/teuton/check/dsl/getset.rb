module CheckDSL
  def get(varname)
    @stats[:gets] += 1
    @gets[varname] = @gets[varname] ? (@gets[varname] + 1) : 1
    "get(#{varname})"
  end

  def gett(option)
    get(option)
  end

  def set(key, value)
    key = ":" + key.to_s if key.instance_of? Symbol
    value = ":" + value.to_s if value.instance_of? Symbol

    @stats[:sets] << "#{key}=#{value}"
    puts "      set(#{key},#{value})"
  end

  def unset(key)
    puts "      unset(#{key})"
  end
end
