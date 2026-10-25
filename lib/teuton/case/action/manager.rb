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

    def close
      trigger_events!
      @current_action = nil
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

    def stopped?
      @stopped
    end

    def scores_to_zero
      @actions.each { |action| action.score = 0.0 }
    end

    def score
      @actions.map { _1.score }.sum
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

      @current_action.description = "NODATA"
      @current_action.command = ""
      @current_action.exec = ""
      @current_action.conn_type = "?"
      @current_action.duration = "?"
      @current_action.result = "NODATA"
      @current_action.output = ""
      @current_action.alterations = ""
      @current_action.expected = ""
      @current_action.check = false
      @current_action.score = 0.0
    end
  end
end
