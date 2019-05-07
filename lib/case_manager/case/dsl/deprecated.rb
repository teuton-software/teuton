
module DSL

  def request(text)
    raise 'Deprecated'
    # do nothing by now
  end

  def target2(text=:none)
    raise 'Deprecated'
    return @action[:description] if text == :none
    @action[:description] = text
  end

end
