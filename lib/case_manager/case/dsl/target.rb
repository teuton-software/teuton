# DSL#target
module DSL
  def target(text = :none, args = {})
    # Without params this method only return data
    return @action[:description] if text == :none and args == {}

    # With params this method modify internal data
    @action[:description] = text.to_s
    if args[:asset]
      @action[:asset] = args[:asset]
      if text == :none
        @action[:description] = "(asset => #{args[:asset]})"
      end
    end
  end
  alias_method :goal, :target

end
