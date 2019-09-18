# frozen_string_literal: true

require_relative '../../application'

# Class Case::Config
# * get
# * set
# * unset
class Case
  # This class manage configuration for only one case
  class Config
    attr_reader :global, :local, :running

    def initialize(args)
      @global  = args[:global] || Application.instance.global.clone
      @local   = args[:local]  || {}
      @running = {}

      # Set defaults values
      @local[:tt_skip] = @local[:tt_skip] || false
    end

    # Read param Option from [running, config or global] Hash data
    def get(option)
      return @local[option]   unless @local[option].nil?
      return @running[option] unless @running[option].nil?
      return @global[option]  unless @global[option].nil?

      'NODATA'
    end

    def set(key, value)
      @running[key] = value
    end

    def unset(key)
      @running[key] = nil
    end
  end
end
