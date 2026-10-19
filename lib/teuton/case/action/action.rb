class Case
  class Action
    attr_reader :id
    attr_accessor :groupname, :description, :weight,
                  :command, :encoding, :host, :exec,
                  :conn_type, :duration,
                  :result, :output,
                  :alterations, :expected, :check
    attr_writer :score

    def initialize(id = 1)
      @id = id
      @groupname = nil
      @description = "No description!"
      @weight = 1.0
      @check = false
      @score = nil
    end

    def score
      return @score unless @score.nil?
      return 0.0 if @check == false

      @weight
    end

    def to_h
      {
        id: id,
        groupname: groupname, description: description, weight: weight,
        command: command, encoding: encoding, host: host, exec: exec,
        conn_type: conn_type, duration: duration,
        result: result, output: output,
        alterations: alterations, expected: expected, check: check,
        score: score
      }
    end
  end
end
