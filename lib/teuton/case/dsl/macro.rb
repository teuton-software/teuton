# frozen_string_literal: true

require_relative "../../utils/project"
require_relative "../../utils/logger"

module DSL
  ##
  # Invoke macro
  # @param name (String) Macro name
  # @param input (Hash) Macro params
  def macro(name, input = {})
    macros = Project.value[:macros]
    unless macros[name]
      msg = "DSL '#{name}' not found!"
      log(msg, :error)
      Logger.error("ERROR #{msg}")
      return
    end
    input.each_pair { |k, v| set(k, v) }
    errors = []
    macros[name][:args].each do |i|
      errors << i if get(i) == "NODATA"
    end
    if errors.count > 0
      log("Macro #{name} => required params #{errors.join(",")}", :error)
    else
      instance_eval(&macros[name][:block])
    end
    input.each_pair { |k, v| unset(k) }
  end

  # If a method call is missing, then:
  # * delegate to concept parent.
  # * Invoke macro (assert)
  def method_missing(method, args = {})
    a = method.to_s
    if a.start_with?("_")
      return instance_eval("get(:#{a[1, a.size]})", __FILE__, __LINE__)
    elsif a[0, 6] == "macro_"
      return macro a[6, a.size], args
    end
    macro a, args
  end

  def respond_to_missing?(method, *)
    true
  end
end
