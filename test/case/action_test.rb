require "test/unit"
require_relative "../../lib/teuton/case/action/action"

class CaseActionTest < Test::Unit::TestCase
  def test_first_action
    action = Case::Action.new
    assert_equal 0, action.id
    assert_nil action.groupname
    assert_equal "No description!", action.description
    assert_equal 1.0, action.weight
    assert_equal 0, action.score
  end
end
