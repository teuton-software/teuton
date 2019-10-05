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

  # If a method call is missing, then delegate to concept parent.
  def method_missing(method)
    puts "[DEBUG] Running method_missing #{method}"
    a = method.to_s
    instance_eval("get(:#{a[0, a.size - 1]})") if a[a.size - 1] == '?'
  end
end
