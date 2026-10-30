require_relative "action"
require_relative "event"

class Case
  class ActionManager
    attr_reader :actions, :events, :current_action
    attr_writer :log

    def initialize
      @current_action = nil
      @actions = []
      @events = []
      @stopped = false
      @log = nil
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

    def to_h
      @actions.map { _1.to_h }
    end

    private

    def calculate_grade(report)
      current_good_weight = @actions.sum(&:score)
      current_score = current_good_weight.to_f / @max_weight
      current_score = 0.0 if current_score.nan?

      @grade = (100.0 * current_score).round

      @grade = 0.0 if report.tail[:unique_fault].positive?
      @grade
    end
  end
end
