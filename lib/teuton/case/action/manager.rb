require_relative "action"

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
    attr_reader :actions, :events, :current_action
    attr_writer :log

    def initialize
      @current_action = nil
      @actions = []
      @events = []
      @stopped = false
      @log = nil
    end

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
        events << {id: id, args: args, block: block, type: :eachtime}
        log "Register (sinde target #{last_action.id}) event on: #{object} , when: #{condition}"
      end
    end

    def close(report)
      trigger_events!
      @current_action = nil

      # Calculate final values
      @grade = @max_weight = @good_weight = @fails_weight = @fail_counter = 0
      @history = ""

      @actions.each do |action|
        @max_weight += action.weight if action.weight.positive?

        if action.check
          @good_weight += action.weight
          @history += Settings.letter[:good]
        else
          @fails_weight += action.weight
          @fail_counter += 1
          @history += Settings.letter[:fail]
        end
      end

      report.lines += @actions.map(&:to_h)
      report.history = @history

      report.tail[:max_weight] = @max_weight
      report.tail[:good_weight] = @good_weight
      report.tail[:fail_weight] = @fails_weight
      report.tail[:fail_counter] = @fail_counter
      report.tail[:grade] = calculate_grade(report)
    end

    def last_action
      @actions.last
    end

    def next_action
      if @current_action.nil?
        @current_action = Action.new(1)
        return @current_action
      end

      @actions << @current_action
      @current_action = Action.new(last_action.id + 1)
      @current_action.groupname = last_action.groupname
      @current_action.description = last_action.description
      @current_action
    end

    def current_score
      current_good_weight = @actions.sum(&:score)
      value = current_good_weight.to_f / @max_weight
      value = 0.0 if value.nan?
      value
    end

    def stopped?
      @stopped
    end

    def scores_to_zero
      @actions.each do |action|
        action.score = 0.0
        action.description << " (SCORE TO ZERO)"
      end
      log("Scores READJUSTED!")
    end

    def stop
      @stopped = true
      log("Test STOPPED!")
    end

    def to_h
      @actions.map { _1.to_h }
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

    def calculate_grade(report)
      current_good_weight = @actions.sum(&:score)
      current_score = current_good_weight.to_f / @max_weight
      current_score = 0.0 if current_score.nan?

      @grade = (100.0 * current_score).round

      @grade = 0.0 if report.tail[:unique_fault].positive?
      @grade
    end

    def trigger_on_last_target(args, block)
      do_ok = last_action.check && args[:when] == :is_ok
      do_failed = !last_action.check && args[:when] == :failed
      unless do_ok || do_failed
        id = events.count
        events << {id: id, args: args, block: block, status: :cancelled}
        log "Event[#{id}] cancelled because target[#{last_action.id}] #{args[:when]}"
      end
      id = events.count
      events << {id: id, args: args, block: block, status: :triggered}
      log "Event[#{id}] triggered because target[#{last_action.id}] #{args[:when]}"
      instance_exec(**args, &block) if block
    end

    def trigger_on_all_targets(args, block)
      all_targets_passed = @actions.map { _1.check }.all?
      do_all_passed = all_targets_passed && args[:when] == :is_ok
      all_targets_failed = @actions.map { !_1.check }.all?
      do_all_failed = all_targets_failed && args[:when] == :failed
      unless do_all_passed || do_all_failed
        id = events.count
        events << {id: id, args: args, block: block, status: :cancelled}
        log "Event[#{id}] cancelled. Not all_targets[1, #{last_action.id}] #{args[:when]}"
      end
      id = events.count
      events << {id: id, args: args, block: block, status: :triggered}
      log "Event[#{id}] triggered. All_targets[1, #{last_action.id}] #{args[:when]}"
      instance_exec(**args, &block) if block
    end
  end
end
