module Case
  class ActionManager
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

    def to_h
      # Export all actions as an Array of Hash
    end
  end
end
