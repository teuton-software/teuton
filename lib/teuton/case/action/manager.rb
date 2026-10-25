require_relative "action"

class Case
  class ActionManager
    OBJECTS = %i[last_target every_target all_targets].freeze
    CONDITIONS = %i[failed is_ok].freeze
    ACTIONS = %i[scores_to_zero stop log].freeze

    attr_reader :actions, :events, :current_action

    def initialize
      @current_action = nil
      @actions = []
      @events = {runonce: [], repeat: []}
      @stopped = false
    end

    def add_event(**args, &block)
    end

    def check_event(**args)
      object = args[:on]
      unless Case::ActionManager::OBJECTS.include? object
        Logger.warn "Incorrect argument. Event on: #{object} ..."
        Logger.info "Valid OBJECTS: #{Case::ActionManager::OBJECTS.join(",")}"
        return false
      end
      condition = args[:when]
      unless Case::ActionManager::CONDITIONS.include? condition
        Logger.warn "Incorrect argument. Event ... when: #{condition}"
        Logger.info "Valid CONDITIONS: #{Case::ActionManager::CONDITIONS.join(",")}"
        return false
      end
      true
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

    def exec_block_event(&block)
      args = {}
      instance_exec(**args, &block) if block
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

    def regular_score
      value = @good_weight.to_f / @max_weight
      value = 0.0 if value.nan?
      value
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
    end

    def stop
      @stopped = true
    end

    def to_h
      @actions.map { _1.to_h }
    end

    def trigger_events!
      @events[:repeat].each do |event|
        # TODO: Do something
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

    def calculate_grade(report)
      current_good_weight = @actions.map { _1.score }.sum
      current_score = current_good_weight.to_f / @max_weight
      current_score = 0.0 if current_score.nan?

      @grade = (100.0 * current_score).round

      @grade = 0.0 if report.tail[:unique_fault].positive?
      @grade
    end
  end
end
