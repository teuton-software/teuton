require "test/unit"
require_relative "../../lib/teuton/case/case"

class ExpectOneTest < Test::Unit::TestCase
  def setup
    Project.init
    Project.value[:global] = {tt_testname: "tXX_expect_one_test"}
    Project.value[:verbose] = false
    @case = Case.new({})
  end

  def test_expect_one_string
    configure_result(@case, %w[a b b c])
    @case.expect "a"

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

  def test_expect_one_regexp
    configure_result(@case, %w[aa ab ac bc])
    @case.expect_one(/a/)

    assert_equal false, action[:check]
    assert_equal 3, action[:result]

    configure_result(@case, %w[aa ab ac bc])
    @case.expect_one(/ab/)
    assert action[:check]
    assert_equal 1, action[:result]
  end

  def action = @case.action

  def configure_result(acase, content)
    acase.result.content = content
    acase.result.exitcode = 0
  end
end
