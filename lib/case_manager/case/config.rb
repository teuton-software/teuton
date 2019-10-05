# frozen_string_literal: true

require_relative '../../application'

# Class Case::Config
# * get
# * set
# * unset
# * missing_method
class Case
  # This class manage configuration for only one case
  class Config
    attr_reader :ialias, :global, :local, :running

    def initialize(args)
      @ialias  = args[:alias] || Application.instance.ialias.clone
      @global  = args[:global] || Application.instance.global.clone
      @local   = args[:local]  || {}
      @running = {}

      # Set defaults values
      @local[:tt_skip] = @local[:tt_skip] || false
    end

    # Read param Option from [running, config or global] Hash data
    def get(option)
      return @local[option] if @local[option]

      return @running[option] if @running[option]

      return @global[option] if @global[option]

      search_alias option
    end

    def set(key, value)
      @running[key] = value
    end

    def unset(key)
      @running[key] = nil
    end

    def search_alias(key)
      return get(@ialias[key]) if @ialias[key]

      words = key.to_s.split('_')
      return 'NODATA' if words.size < 2

      return 'NODATA' unless %w[ip hostname username password].include? words[1]

      key2 = @ialias[words[0].to_sym]
      return 'NODATA' unless key2

      get("#{key2}_#{words[1]}".to_sym)
    end
  end
end
