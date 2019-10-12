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
    flag = true
    macros[name][:args].each do |i|
      if get(i) == 'NODATA'
        m = "[ERROR] Calling macro #{name} => required param #{i}"
        puts m
        log m
        flag = false
      end
    end
    instance_eval(&macros[name][:block]) if flag
    input.each_pair { |k, v| unset(k) }
  end
end
