class Case
  class ActionManager
    OBJECTS = %i[last_target every_target all_targets].freeze
    CONDITIONS = %i[failed is_ok].freeze
    ACTIONS = %i[scores_to_zero stop log].freeze
    attr_reader :actions, :events

    def initialize
      @actions = []
      @events = []
    end

    def trigger_events!
      @events.each do |event|
        # TODO: Do something
      end
    end

    def scores_to_zero
    end

    def stop
    end

    def to_h
      # Export all actions as an Array of Hash
    end
  end
end
