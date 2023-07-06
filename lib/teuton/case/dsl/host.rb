module DSL
  def get_host(id)
    Case::Host.new(config).get(id)
  end
end
