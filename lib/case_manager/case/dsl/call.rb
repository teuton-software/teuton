# frozen_string_literal: true
require_relative '../../../application'

# DSL#call
module DSL
  def call(name, input = {})
    macros = Application.instance.macros
    unless macros[name]
      puts "[ERROR] Macro #{name} not found!"
      return
    end
    input.each_pair { |k, v| set(k, v) }
    errors = []
    macros[name][:args].each do |i|
      errors << i if get(i) == 'NODATA'
    end
    if errors.count > 0
      m = "[ERROR] Calling macro #{name} => required params #{errors.join(',')}"
      puts m
      log m
    else
      instance_eval(&macros[name][:block])
    end
    input.each_pair { |k, v| unset(k) }
  end
end
