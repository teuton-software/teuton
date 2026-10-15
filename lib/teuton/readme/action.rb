class Readme
  class Action
    attr_reader :id
    attr_accessor :description, :weight, :readme, :host, :exec

    def initialize
      @id = 0
      @description = nil
      @host = nil
      @readme = []
    end

    def reset
      @id += 1
      @description = nil
      @host = nil
      @readme = []
      self
    end

    def to_h
      {
        id: id,
        description: description, weight: weight, readme: readme,
        host: host, exec: exec
      }
    end
  end
end
