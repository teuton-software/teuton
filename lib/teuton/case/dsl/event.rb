module DSL
  def event(**args, &block)
    return unless @action_manager.check_event(**args)

    object = args[:on]
    condition = args[:when]

    if object == :every_target
      @action_manager.events << {args: args, block: block}
    else
      # last_target, all_targets
      log "Event on: #{object} (target #{last_action.id}), when: #{condition}"
      @action_manager.instance_exec(**args, &block) if block
      # TODO: do something more
    end
  end
end
