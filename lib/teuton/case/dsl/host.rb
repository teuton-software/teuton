module DSL
  def host(id)
    Case::Host.new(id, config)
  end
end
