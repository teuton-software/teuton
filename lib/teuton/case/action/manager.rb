require_relative "action"

class Case
  class ActionManager
    OBJECTS = %i[last_target every_target all_targets].freeze
    CONDITIONS = %i[failed is_ok].freeze
    ACTIONS = %i[scores_to_zero stop log].freeze

    attr_reader :actions, :events, :current_action

    def initialize
      @current_action = Action.new
      @actions = []
      @actions << @current_action
      @events = { runonce: [], repeat: [] }
      @stopped = false
    end

    def add_event(...)
    end

    def check_event(...)
    end

    def next_action
      new_action = Action.new(@current_action.id + 1)
      new_action.groupname = @current_action.groupname
      new_action.description = @current_action.description
      @current_action = new_action
      @actions << @current_action
      @current_action
    end

    def stopped?
      @stopped
    end

    def trigger_events!
      @events[:repeat].each do |event|
        # TODO: Do something
      end
    end

    def scores_to_zero
      @action.each { |action| action.score = 0 }
    end

    def stop
      @stop_test = true
    end

    def to_h
      # Export all actions as an Array of Hash
    end
  end
end
