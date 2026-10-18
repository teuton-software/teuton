require "test/unit"
require_relative "../../lib/teuton/case/action/manager"

class CaseActionManagerTest < Test::Unit::TestCase
  def test_initialize
    am = Case::ActionManager.new
    assert_equal 0, am.actions.size
    assert_equal 0, am.events[:runonce].size
    assert_equal 0, am.events[:repeat].size
    assert_false am.stopped?
  end
end
