class Case
  class Action
    attr_reader :id
    attr_accessor :groupname, :description, :weight, :asset,
                  :command, :encoding, :host, :exec, :conn_type, :duration,
                  :result, :output, :alterations, :expected, :check

    def initialize
      @id = 0
      @groupname = nil
      @description = "No description!"
      @weight = 1.0
    end

    def next
      @id += 1
      self
    end

    def to_h
      {
        id: id,
        groupname: groupname, description: description, weight: weight, asset: asset,
        command: command, encoding: encoding, host: host, exec: exec,
        conn_type: conn_type, duration: duration,
        result: result, output: output,
        alterations: alterations, expected: expected, check: check
      }
    end
  end
end
