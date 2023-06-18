# frozen_string_literal: true

module DSL
  def expect_exit(value)
    @result.alterations = "Read exit code"
    real_value = result.exitcode
    cond = if value.is_a? Range
      expect_value = "With range #{value}"
      value.to_a.include? real_value
    elsif value.is_a? Array
      expect_value = "Inside list #{value}"
      value.include? real_value
    else
      expect_value = value
      (real_value == value.to_i)
    end
    expect2 cond, value: real_value, expected: expect_value
  end

  def expect_fail
    @result.alterations = "Read exit code"
    real_value = result.exitcode
    expect_value = "Greater than 0"
    cond = (real_value > 0)
    expect2 cond, value: real_value, expected: expect_value
  end

  def expect_ok
    expect_exit 0
  end
end
