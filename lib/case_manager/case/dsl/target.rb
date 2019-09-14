# frozen_string_literal: true

# DSL#target
module DSL
  def readme(_text)
    # Usefull for "teuton reamde" action.
  end

  def target(desc, args = {})
    weight(1.0)
    @action[:description] = desc.to_s
    @action[:asset] = args[:asset].to_s if args[:asset]
    weight(args[:weight]) if args[:weight]
  end
  alias goal target
end
