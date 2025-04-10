module ReadmeDSL
  def get(value)
    unless @config[:global][value].nil?
      @global_params[value] = @config[:global][value]
      return @config[:global][value]
    end

    return value.to_s.upcase if @setted_params.include? value

    @cases_params << value
    value.to_s.upcase
  end

  def gett(value)
    a = get(value)
    if @cases_params.include? value
      "[" + value + "](#required-params)"
    elsif @setted_params[value]
      "[" + value + "](#created-params)"
    elsif @global_params.include? value
      "[" + a + "](#global-params)"
    end
    a
  end

  def set(key, value)
    @setted_params[key] = value
  end

  def unset(_key)
    # Nothing to do
  end
end
