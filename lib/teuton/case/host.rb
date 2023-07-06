class Case
  class Host
    attr_reader :id
    attr_reader :ip
    attr_reader :username
    attr_reader :password
    attr_reader :port
    attr_reader :protocol
    attr_reader :route

    def initialize(config)
      @config = config
    end

    def get(id = nil)
      if id.nil?
        init_nil
      else
        init(id)
      end
      self
    end

    def to_s
      data = {
        id: id,
        ip: ip, username: username, password: password,
        port: port, protocol: protocol, route: route
      }
      data.to_s
    end

    private

    def init(id)
      @id = id.to_sym
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

    def init_nil
      @id = :localhost
      @ip = "127.0.0.1"
      @username = "NODATA"
      @password = "NODATA"
      @protocol = "local"
      @port = 0
      @route = "NODATA"
    end
  end
end
