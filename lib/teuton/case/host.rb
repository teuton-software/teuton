class Case
  class Host
    attr_reader :id
    attr_reader :ip
    attr_reader :username
    attr_reader :password
    attr_reader :port
    attr_reader :protocol
    attr_reader :route

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
      @protocol = @config.get("#{@id}_protocol".to_sym).to_s.downcase
      @protocol = "ssh" if @protocol == "nodata"
      @port = @config.get("#{@id}_port".to_sym).to_i
      if @port.zero?
        default = {"local" => 0, "ssh" => 22, "telnet" => 23, "NODATA" => 22}
        @port = default[@protocol]
      end
      @route = @config.get("#{@id}_route".to_sym)
    end

    def to_s
      data = {
        id: id,
        ip: ip, username: username, password: password,
        port: port, protocol: protocol, route: route
      }
      data.to_s
    end
  end
end
