class Case
  class ActionManager
    OBJECTS = %i[last_target every_target all_targets].freeze
    CONDITIONS = %i[failed is_ok].freeze
    ACTIONS = %i[scores_to_zero stop log].freeze

    attr_reader :actions, :events

    def initialize
      @actions = []
      @events = {runonce: [], repeat: []}
      @stopped = false
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
