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

  def test_to_hash
    action = Case::Action.new
    data1 = { id: 1, groupname: nil, description: "No description!", weight: 1.0 }
    data2 = action.to_h

    assert_equal data1[:id], data2[:id]
    assert_equal data1[:groupname], data2[:groupname]
    assert_equal data1[:description], data2[:description]
    assert_equal data1[:weight], data2[:weight]
  end
end
