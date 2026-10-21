require "test/unit"
require_relative "../../lib/teuton/case/action/manager"

class CaseActionManagerTest < Test::Unit::TestCase
  def test_initialize
    am = Case::ActionManager.new
    assert_equal 1, am.actions.size
    assert_equal 0, am.events[:runonce].size
    assert_equal 0, am.events[:repeat].size
    assert_equal 1, am.current_action.id
    assert_false am.stopped?
  end

  def test_several_actions
    am = Case::ActionManager.new
    assert_equal 1, am.actions.size
    assert_equal 1, am.current_action.id
    am.next_action
    assert_equal 2, am.actions.size
    assert_equal 2, am.current_action.id
  end

  def test_to_hash
    am = Case::ActionManager.new
    a = am.current_action
    a.description = "First action"
    a = am.next_action
    a.description = "Second action"

    assert_equal "First action", am.to_h[0][:description]
    assert_equal "Second action", am.to_h[1][:description]
  end
end
