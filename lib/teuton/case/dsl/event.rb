module DSL
  def event(**args, &block)
    type = @action_manager.add_event(**args, &block)

    return unless type == :now

    object = args[:on]
    condition = args[:when]
    log "Event on: #{object} (target #{last_action.id}), when: #{condition}"
  end
end
