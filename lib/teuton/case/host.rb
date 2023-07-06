class Case
  class Host
    attr_reader :id
    attr_reader :ip
    attr_reader :username
    attr_reader :password
    attr_reader :port

    def initialize(id, config)
      @id = id
      @config = config
      reset
    end

    private

    def reset
      @ip = @config.get("#{@id}_ip".to_sym).to_s
      @username = @config.get("#{@id}_username".to_sym).to_s
      @password = @config.get("#{@id}_password".to_sym).to_s
      @port = @config.get("#{hostname}_port".to_sym).to_i
      @port = 22 if @port.zero?
    end
  end
end