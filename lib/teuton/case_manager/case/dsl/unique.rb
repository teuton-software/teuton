# frozen_string_literal: true

module DSL
  def unique(key, value)
    return if value.nil?

    @uniques << "#{key}=#{value}".to_sym
  end
end
