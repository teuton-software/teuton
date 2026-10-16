module DSL
  def event(*args, &block)
    # args = on: XXX, when: XXX
    Project.value[:events] << {args: args, block: block}
  end
end
