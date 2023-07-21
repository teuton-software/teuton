# frozen_string_literal: true

module ReadmeDSL
  def expect(_cond, _args = {})
    @current[:actions] << @action
    result.reset
  end
  alias_method :expect_any, :expect
  alias_method :expect_exit, :expect
  alias_method :expect_first, :expect
  alias_method :expect_last, :expect
  alias_method :expect_one, :expect

  def expect_fail
    @current[:actions] << @action
    result.reset
  end
  alias_method :expect_ok, :expect_fail

  def expect_none(cond = nil)
    expect(cond)
  end
  alias_method :expect_nothing, :expect_none
end
