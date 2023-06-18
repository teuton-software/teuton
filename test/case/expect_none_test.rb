require "test/unit"
require_relative "../../lib/teuton/case/case"

class ExpectNoneTest < Test::Unit::TestCase
  def setup
    Project.init
    Project.value[:global] = {tt_testname: "tXX_expect_none_test"}
    @case = Case.new({})
  end

  def test_expect_none_string
    configure_result(@case, %w[a b b c])
    @case.expect_none "d"

    assert action[:check]
    assert_equal 0, action[:result]
    assert_equal "find(d) & count", action[:alterations]
    assert_equal "0", action[:expected]
  end

  def test_expect_none_regexp
    configure_result(@case, %w[aa ab ac bc])
    @case.expect_none(/bb/)

    assert_equal true, action[:check]
    assert_equal 0, action[:result]
    assert_equal "find((?-mix:bb)) & count", action[:alterations]
    assert_equal "0", action[:expected]
  end

  def action = @case.action

  def configure_result(acase, content)
    acase.result.content = content
    acase.result.exitcode = 0
  end
end
