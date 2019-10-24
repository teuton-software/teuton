# frozen_string_literal: true
require_relative '../../../application'

# DSL#call
module DSL
  def check(name, input = {})
    checks = Application.instance.checks
    unless checks[name]
      puts "[ERROR] Check #{name} not found!"
      return
    end
    input.each_pair { |k, v| set(k, v) }
    errors = []
    checks[name][:args].each do |i|
      errors << i if get(i) == 'NODATA'
    end
    if errors.count > 0
      m = "[ERROR] Check #{name} => required params #{errors.join(',')}"
      puts m
      log m
    else
      instance_eval(&checks[name][:block])
    end
    input.each_pair { |k, v| unset(k) }
  end
end
