module DSL
  def event(*args, &block)
    # args = on: XXX, when: XXX
    @action_manager.events << { args: args, block: block }
  end
end
