module DSL
  def event(**args, &block)
    msg = @action_manager.add_event(**args, &block)
    log(msg) unless msg.empty?
  end
end
