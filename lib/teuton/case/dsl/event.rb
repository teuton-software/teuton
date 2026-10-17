module DSL
  def event(**args, &block)
    # args = on: XXX, when: XXX
    if args[:on] == "last_target"
      log "Event triggered on: #{args[:on]}, when: #{args[:when]} Target #{@action.id}"
      # TODO: do something more
    end
    @action_manager.events << {args: args, block: block}
  end
end
