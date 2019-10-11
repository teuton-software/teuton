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
    instance_eval(&macros[name][:block])
  end
end
