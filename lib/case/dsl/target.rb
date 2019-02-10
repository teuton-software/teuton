# encoding: utf-8

module DSL

  def target(text=nil)
    return @action[:description] if text.nil?
    @action[:description] = text
  end
  alias_method :goal, :target

end
