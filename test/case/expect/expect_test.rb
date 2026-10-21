require "test/unit"
require_relative "../../../lib/teuton/case/case"

class ExpectTest < Test::Unit::TestCase
  def setup
    Project.init
    Project.value[:global] = {tt_testname: "tXX_expect_test"}
    Project.value[:verbose] = false
  end

  def test_expect_string
    acase = Case.new({})

    configure_result(acase, %w[a b b c])
    acase.expect "a"
    action = acase.last_action

    assert action.check
    assert_equal 1, action.result
    assert_equal "find(a) & count", action.alterations
    assert_equal "Greater than 0", action.expected

    configure_result(acase, %w[a b b c])
    acase.expect "b"
    action = acase.last_action

    assert action.check
    assert_equal 2, action.result

    configure_result(acase, %w[a b b c])
    acase.expect "c"
    action = acase.last_action

    assert action.check
    assert_equal 1, action.result
  end

  def test_expect_any_string_fail
    acase = Case.new({})

    configure_result(acase, %w[a b b c])
    acase.expect "d"
    action = acase.last_action

    assert_equal false, action.check
    assert_equal 0, action.result
  end

  def test_expect_regexp
    acase = Case.new({})

    configure_result(acase, %w[aa ab ac bc])
    acase.expect(/aa/)
    action = acase.last_action

    assert action.check
    assert_equal 1, action.result
    assert_equal "find((?-mix:aa)) & count", action.alterations
    assert_equal "Greater than 0", action.expected

    configure_result(acase, %w[aa ab ac bc])
    acase.expect(/a/)
    action = acase.last_action

    assert action.check
    assert_equal 3, action.result

    configure_result(acase, %w[aa ab ac bc])
    acase.expect(/a|b/)
    action = acase.last_action

    assert action.check
    assert_equal 4, action.result
  end

  def test_expect_regexp_fail
    acase = Case.new({})

    configure_result(acase, %w[aa ab ac bc])
    acase.expect(/d/)
    action = acase.last_action

    assert_equal false, action.check
    assert_equal 0, action.result
  end

  def configure_result(acase, content)
    acase.result.content = content
    acase.result.exitcode = 0
  end
end
