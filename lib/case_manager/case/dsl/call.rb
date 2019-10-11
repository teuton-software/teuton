# frozen_string_literal: true
require_relative '../../../application'

# DSL#call
module DSL
  def call(name, args = {})
    macros = Application.instance.macros
    unless macros[name]
      puts "[ERROR] Macro #{name} not found!"
      return
    end
    args.each_pair { |k, v| set(k, v) }
    instance_eval(&macros[name][:block])
    args.each_pair { |k, v| unset(k) }
  end
end
