require_relative "action"

class Case
  class ActionManager
    OBJECTS = %i[last_target every_target all_targets].freeze
    CONDITIONS = %i[failed is_ok].freeze
    ACTIONS = %i[scores_to_zero stop log].freeze

    attr_reader :actions, :events, :current_action

    def initialize
      @actions = []
      @current_action = nil
      @events = {runonce: [], repeat: []}
      @stopped = false
    end

    def add_event(...)
    end

    def check_event(...)
    end

    def new_action
      @current_action = if @current_action.nil?
        Action.new
      else
        @current_action.next
      end
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
