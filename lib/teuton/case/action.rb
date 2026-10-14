class Case
  class Action
    BASE_ID = -1
    @current_id = BASE_ID

    def self.next_id
      @current_id += 1
    end

    def self.reset
      @current_id = BASE_ID
    end

    attr_reader :id
    attr_accessor :groupname, :description, :weight, :asset,
      :command, :encoding, :host, :exec, :conn_type, :duration,
      :result, :output, :alterations, :expected,
      :check, :tempfile, :remote_tempfile

    def initialize
      @id = Action.next_id
      @groupname = nil
      @description = "No description!"
      @weight = 1.0
    end

    def next
      @id = Action.next_id
    end

    def to_h
      {
        id: id,
        groupname: groupname, description: description, weight: weight, asset: asset,
        command: command, encoding: encoding, host: host, exec: exec,
        conn_type: conn_type, duration: duration,
        result: result, output: output,
        alterations: alterations, expected: expected,
        check: check,
        tempfile: tempfile, remote_tempfile: remote_tempfile
      }
    end
  end
end
