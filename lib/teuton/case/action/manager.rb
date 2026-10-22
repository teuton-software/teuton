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
      @events = { runonce: [], repeat: [] }
      @stopped = false
    end

    def add_event(...)
    end

    def check_event(...)
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

      if @stopped
        # TODO
      end
      @actions << @current_action
      @current_action = Action.new(last_action.id + 1)
      @current_action.groupname = last_action.groupname
      @current_action.description = last_action.description
      @current_action
    end

    def stopped?
      @stopped
    end

    def scores_to_zero
      @action.each { |action| action.score = 0 }
    end

    def stop
      @stopped = true
      Logger.warn("stop()!")
    end

    def to_h
      @actions.map { _1.to_h }
    end

    def trigger_events!
      @events[:repeat].each do |event|
        # TODO: Do something
      end
    end
  end
end
