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
        init_default
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
      @ip = @config.get(:"#{@id}_ip").to_s
      @username = @config.get(:"#{@id}_username").to_s
      @password = @config.get(:"#{@id}_password").to_s

      @protocol = @config.get(:"#{@id}_protocol").to_s.downcase
      if @protocol == "nodata"
        @protocol = if @ip == "localhost" || @ip.start_with?("127.0.0.")
          "local"
        else
          "ssh"
        end
      end

      @port = @config.get(:"#{@id}_port").to_i
      if @port.zero?
        default = {"local" => 0, "ssh" => 22, "telnet" => 23}
        @port = default[@protocol]
      end
      @route = @config.get(:"#{@id}_route")
    end

    def init_default
      @id = :default
      @ip = "localhost"
      @username = "NODATA"
      @password = "NODATA"
      @protocol = "local"
      @port = 0
      @route = "NODATA"
    end
  end
end
