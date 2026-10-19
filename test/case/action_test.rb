require "test/unit"
require_relative "../../lib/teuton/case/action/action"

class CaseActionTest < Test::Unit::TestCase
  def test_action_attr_and_score
    action = Case::Action.new
    assert_equal 1, action.id
    assert_nil action.groupname
    assert_equal "No description!", action.description
    assert_equal 1.0, action.weight

    action.check = false
    assert_equal 0.0, action.score
    action.check = true
    assert_equal 1.0, action.score
    action.weight = 2.3
    assert_equal 2.3, action.score
  end
end
