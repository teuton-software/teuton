# frozen_string_literal: true

# Case#DSL#unique
module DSL
  def unique(key, value)
    return if value.nil?

    k = (key.to_s + '=' + value.to_s).to_sym
    @uniques << k
  end
end
