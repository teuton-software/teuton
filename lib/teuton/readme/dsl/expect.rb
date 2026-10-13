# frozen_string_literal: true

module ReadmeDSL
  def expect(_cond, _args = {})
    @current[:actions] << @action.to_h
    result.reset
  end
  alias expect_any expect
  alias expect_exit expect
  alias expect_first expect
  alias expect_last expect
  alias expect_one expect

  def expect_fail
    @current[:actions] << @action.to_h
    result.reset
  end
  alias expect_ok expect_fail

  def expect_none(cond = nil)
    expect(cond)
  end
  alias expect_nothing expect_none

  def expect_sequence(&block)
    @current[:actions] << @action.to_h
    result.reset
  end
end
