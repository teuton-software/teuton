# frozen_string_literal: true

# DSL#target
module DSL
  def readme(_text)
    # Usefull only for "teuton reamde" command action.
  end

  def target(desc, args = {})
    @action[:description] = desc.to_s
    @action[:asset] = args[:asset].to_s if args[:asset]
    w = args[:weight] || 1.0
    weight(w)
  end
  alias goal target
end
