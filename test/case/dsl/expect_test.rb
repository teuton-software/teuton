require "test/unit"
require_relative "../../../lib/teuton/case/case"

class ExpectTest < Test::Unit::TestCase
  def setup
    Project.init
    Project.value[:global] = {tt_testname: "tXX_expect_test"}
    @case = Case.new({})
  end

  def test_string_one
    result = @case.result
    result.content = %w[a b b d]
    result.exitcode = 0
    @case.expect "a"
    action = @case.action

    assert action[:check]
    assert_equal 1, action[:result]
    assert_equal "find(a) & count", action[:alterations]
    assert_equal "Greater than 0", action[:expected]

    result.content = %w[a b b d]
    result.exitcode = 0
    @case.expect_one "a"
    assert action[:check]
    assert_equal 1, action[:result]

    result.content = %w[a b b d]
    result.exitcode = 0
    @case.expect_one "b"
    assert_equal false, action[:check]
    assert_equal 2, action[:result]
  end
end
