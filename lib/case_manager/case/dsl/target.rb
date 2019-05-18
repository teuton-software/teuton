# DSL#target
module DSL
  def target(desc, args = {})
    weight(1.0)
    @action[:description] = desc.to_s
    @action[:asset] = args[:asset].to_s if args[:asset]
    weight(args[:weight]) if args[:weight]
  end
  alias goal target
end
