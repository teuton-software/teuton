class Case
  class ActionManager
    AVAILABLE = [
      %i[last_target failed now],
      %i[last_target passed now],
      %i[every_target failed eachtime],
      %i[every_target passed eachtime],
      %i[all_targets failed atend],
      %i[all_targets passed atend]
    ].freeze

    def check_event(args)
      object = args[:on]
      condition = args[:when]
      options = AVAILABLE.select { |obj, cond| obj == object && cond == condition }
      if options.empty?
        Logger.warn "Unkown! Event on: #{object}, when: #{condition}"
        return false
      elsif options.count > 1
        Logger.warn "More than one definition! Event on: #{object}, when: #{condition}"
      end
      true
    end

    def add_event(args, block)
      return unless check_event(args)

      object = args[:on]
      condition = args[:when]
      if object == :last_target
        trigger_on_last_target(args, block)
      elsif object == :all_targets
        trigger_on_all_targets(args, block)
      else
        id = events.count
        events << { id: id, args: args, block: block, type: :eachtime }
        log "Register (sinde target #{last_action.id}) event on: #{object} , when: #{condition}"
      end
    end

    def scores_to_zero
      @actions.each do |action|
        action.score = 0.0
        action.description << " (SCORE TO ZERO)"
      end
      log("Scores set to ZERO!")
    end

    def stop
      @stopped = true
      log("Test STOPPED!")
    end

    def trigger_events!
      @events.each do |event|
        # TODO: Do something if type == :eachtime
      end

      return unless @stopped

      @current_action.description = "TEST STOPPED!"
      @current_action.command = ""
      @current_action.exec = ""
      @current_action.conn_type = "?"
      @current_action.duration = "?"
      @current_action.result = ""
      @current_action.output = ""
      @current_action.alterations = ""
      @current_action.expected = ""
      @current_action.check = false
      @current_action.score = 0.0
    end

    private

    def log(...)
      return if @log.nil?

      @log.call(...)
    end

    def trigger_on_last_target(args, block)
      do_ok = last_action.check && args[:when] == :is_ok
      do_failed = !last_action.check && args[:when] == :failed
      id = events.count
      if do_ok || do_failed
        events << { id: id, args: args, block: block, status: :triggered }
        log "Event[#{id}] triggerd because target[#{last_action.id}] #{args[:when]}"
        instance_exec(**args, &block) if block
      else
        events << { id: id, args: args, block: block, status: :cancelled }
        log "Event[#{id}] cancelled because target[#{last_action.id}] #{args[:when]}"
      end
    end

    def trigger_on_all_targets(args, block)
      all_targets_passed = @actions.map(&:check).all?
      do_all_passed = all_targets_passed && args[:when] == :is_ok
      all_targets_failed = @actions.map { !_1.check }.all?
      do_all_failed = all_targets_failed && args[:when] == :failed
      id = events.count
      if do_all_passed || do_all_failed
        events << { id: id, args: args, block: block, status: :triggered }
        log "Event[#{id}] triggered. All targets[1, #{last_action.id}] #{args[:when]}"
        instance_exec(**args, &block) if block
      else
        events << { id: id, args: args, block: block, status: :cancelled }
        log "Event[#{id}] cancelled. Not all targets[1, #{last_action.id}] #{args[:when]}"
      end
    end
  end
end
