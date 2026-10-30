module DSL
  def event(**args, &block)
    @action_manager.add_event(args, block)
  end
end
