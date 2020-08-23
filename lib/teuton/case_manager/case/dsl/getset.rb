# frozen_string_literal: true

# DSL#get and DSL#set
module DSL
  # Read param option from [running, config or global] Hash data
  def get(option)
    @config.get(option)
  end

  def gett(option)
    value = get(option)
    "#{value} (#{option})"
  end

  def set(key, value)
    @config.set(key, value)
  end

  def unset(key)
    @config.unset(key)
  end
end
