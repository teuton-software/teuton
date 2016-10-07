
class Case

  class Config

    attr_reader :global, :local, :running

    def initialize(pArgs)
      @global  = pArgs[:global] || Application.instance.global.clone
      @local   = pArgs[:local]  || {}
      @running = {}

      #Set defaults values
      @local[:tt_skip] = @local[:tt_skip] || false
    end

    #Read param pOption from [running, config or global] Hash data
    def get(pOption)
      return @local[pOption]   unless @local[pOption].nil?
      return @running[pOption] unless @running[pOption].nil?
      return @global[pOption]  unless @global[pOption].nil?
      return nil
    end

    def set( key, value)
      @running[key]=value
    end

  end

end
