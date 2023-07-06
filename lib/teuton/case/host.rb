class Case
  class Host
    attr_reader :id
    attr_reader :ip
    attr_reader :username
    attr_reader :password
    attr_reader :port

    def initialize(id, config)
      @id = id.to_sym
      @id2s = @id.to_s
      @config = config
      reset
    end

    private

    def reset
      @ip = @config.get("#{@id}_ip".to_sym).to_s
      @username = @config.get("#{@id}_username".to_sym).to_s
      @password = @config.get("#{@id}_password".to_sym).to_s
      @port = @config.get("#{@id}_port".to_sym).to_i
      @port = 22 if @port.zero?
    end

    def to_s
      data = { id: id, ip: ip, port: port,
        username: username, password: password, 
      }
      data.to_s
    end
  end
end
