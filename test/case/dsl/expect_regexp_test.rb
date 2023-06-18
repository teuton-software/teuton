require "test/unit"
require_relative "../../../lib/teuton/case/case"

class ExpectRegexpTest < Test::Unit::TestCase
  def setup
    Project.init
    Project.value[:global] = {tt_testname: "tXX_expect_string_test"}
    @case = Case.new({})
  end

  def test_regexp
    action = @case.action

    configure_result(@case, %w[aa ab ac bc])
    @case.expect(/aa/)
    assert action[:check]
    assert_equal 1, action[:result]
    assert_equal "find((?-mix:aa)) & count", action[:alterations]
    assert_equal "Greater than 0", action[:expected]

    configure_result(@case, %w[aa ab ac bc])
    @case.expect(/a/)
    assert action[:check]
    assert_equal 3, action[:result]

    configure_result(@case, %w[aa ab ac bc])
    @case.expect(/a|b/)
    assert action[:check]
    assert_equal 4, action[:result]
  end

  def test_regexp_one
    action = @case.action

    configure_result(@case, %w[aa ab ac bc])
    @case.expect_one(/a/)

    assert_equal false, action[:check]
    assert_equal 3, action[:result]

    configure_result(@case, %w[aa ab ac bc])
    @case.expect_one(/ab/)
    assert action[:check]
    assert_equal 1, action[:result]
  end

  def configure_result(acase, content)
    acase.result.content = content
    acase.result.exitcode = 0
  end
end
