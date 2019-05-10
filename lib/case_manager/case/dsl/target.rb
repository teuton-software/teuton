# DSL#target
module DSL
  def target(input = :none)
    # Without params this method only return data
    return @action[:description] if input == :none

    # With params this method modify internal data
    @action[:description] = input if input.class == String
    @action[:description] = input[:asset].to_s if input.class == Hash
    @action[:description]
  end
  alias goal target
end
