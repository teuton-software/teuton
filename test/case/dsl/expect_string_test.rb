require "test/unit"
require_relative "../../../lib/teuton/case/case"

class ExpectStringTest < Test::Unit::TestCase
  def setup
    Project.init
    Project.value[:global] = {tt_testname: "tXX_expect_string_test"}
    @case = Case.new({})
  end

  def test_string
    action = @case.action

    configure_result(@case, %w[a b b c])
    @case.expect "a"
    assert action[:check]
    assert_equal 1, action[:result]
    assert_equal "find(a) & count", action[:alterations]
    assert_equal "Greater than 0", action[:expected]

    configure_result(@case, %w[a b b c])
    @case.expect "b"
    assert action[:check]
    assert_equal 2, action[:result]

    configure_result(@case, %w[a b b c])
    @case.expect "d"
    assert_equal false, action[:check]
    assert_equal 0, action[:result]
  end

  def test_string_one
    configure_result(@case, %w[a b b c])
    @case.expect "a"
    action = @case.action

    assert action[:check]
    assert_equal 1, action[:result]
    assert_equal "find(a) & count", action[:alterations]
    assert_equal "Greater than 0", action[:expected]

    configure_result(@case, %w[a b b c])
    @case.expect_one "a"
    assert action[:check]
    assert_equal 1, action[:result]

    configure_result(@case, %w[a b b c])
    @case.expect_one "b"
    assert_equal false, action[:check]
    assert_equal 2, action[:result]

    configure_result(@case, %w[a b b c])
    @case.expect_one "d"
    assert_equal false, action[:check]
    assert_equal 0, action[:result]
  end

  def configure_result(acase, content)
    acase.result.content = content
    acase.result.exitcode = 0
  end
end
