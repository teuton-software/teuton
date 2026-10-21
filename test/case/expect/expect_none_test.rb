require "test/unit"
require_relative "../../../lib/teuton/case/case"

class ExpectNoneTest < Test::Unit::TestCase
  def setup
    Project.init
    Project.value[:global] = {tt_testname: "tXX_expect_none_test"}
    Project.value[:verbose] = false
  end

  def test_expect_none_string
    acase = Case.new({})
    configure_result(acase, %w[a b b c])
    acase.expect_none "d"
    action = acase.last_action

    assert action.check
    assert_equal 0, action.result
    assert_equal "find(d) & count", action.alterations
    assert_equal "0", action.expected
  end

  def test_expect_none_regexp
    acase = Case.new({})
    configure_result(acase, %w[aa ab ac bc])
    acase.expect_none(/bb/)
    action = acase.last_action

    assert_equal true, action.check
    assert_equal 0, action.result
    assert_equal "find((?-mix:bb)) & count", action.alterations
    assert_equal "0", action.expected
  end

  def configure_result(acase, content)
    acase.result.content = content
    acase.result.exitcode = 0
  end
end
