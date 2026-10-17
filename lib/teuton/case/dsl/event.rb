module DSL
  def event(**args, &block)
    # args = on: XXX, when: XXX
    object = args[:on]
    unless Case::ActionManager::OBJECTS.include? object
      Logger.warn "Incorrect argument in event on: #{object} ..."
      Logger.info "Valid OBJECTS: #{Case::ActionManager::OBJECTS.join(',')}"
      return
    end
    condition = args[:when]
    unless Case::ActionManager::CONDITIONS.include? condition
      Logger.warn "Incorrect argument in event on: :#{object} when: #{condition}"
      Logger.info "Valid CONDITIONS: #{Case::ActionManager::CONDITIONS.join(',')}"
      return
    end

    if object == :last_target
      log "Event triggered on: #{object}, when: #{condition} Target #{@action.id}"
      # TODO: do something more
    end
    @action_manager.events << { args: args, block: block }
  end
end
