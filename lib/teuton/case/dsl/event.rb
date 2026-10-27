module DSL
  def event(**args, &block)
    type = @action_manager.get_event_type(**args)
    return if type.nil?

    object = args[:on]
    condition = args[:when]

    if type == :now
      # last_target, all_targets
      log "Event on: #{object} (target #{last_action.id}), when: #{condition}"
      @action_manager.instance_exec(**args, &block) if block
      # TODO: do something more
    else
      @action_manager.events << {args: args, block: block}
    end
  end
end
