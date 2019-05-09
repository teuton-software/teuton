#!/usr/bin/env ruby

require 'minitest/autorun'
require_relative '../../../../lib/case_manager/case/case_model/group_model'

# MiniTest GroupModel Class
class GroupModelTest < Minitest::Test
  def setup
    @gm1 = CaseModel::GroupModel.new('group1_name')

    @gm2 = CaseModel::GroupModel.new('group2_name')
    @gm2.target_new('target1_desc')
    tm1 = @gm2.target

    @gm2.target_new('target2_desc', :asset => 'README.md')
    tm2 = @gm2.target
    tm2.hostname = 'target2_hostname'
    tm2.command = 'target2_command'
    tm2.encoding = 'CP-350'
    tm2.duration = 6
    tm2.id = 2
    tm2.weight = 2.5
    tm2.check = true
    tm2.result = 'target2_result'
    tm2.alterations = 'target2_alterations'
    tm2.expected = 'target2_expected'
  end

  def test_group_model1
    assert_equal 'group1_name', @gm1.name
    assert_equal 0, @gm1.targets.size
  end

  def test_group_model2
    assert_equal 'group2_name', @gm2.name
    assert_equal 2, @gm2.targets.size
    assert_equal @gm2.targets[1], @gm2.target
  end

  def test_gm2_target1
    tm1 = @gm2.targets[0]
    assert_equal 'target1_desc', tm1.description
    assert_nil tm1.asset
    assert_equal '', tm1.hostname
    assert_equal '', tm1.command
    assert_equal 'UTF-8', tm1.encoding
    assert_equal 0, tm1.duration
    assert_equal 0, tm1.id
    assert_equal 1.0, tm1.weight
    assert_equal false, tm1.check
    assert_equal '', tm1.result
    assert_equal '', tm1.alterations
    assert_equal '', tm1.expected
  end

  def test_gm2_target2
    tm2 = @gm2.targets[1]
    assert_equal 'target2_desc', tm2.description
    assert_equal 'README.md', tm2.asset
    assert_equal 'target2_hostname', tm2.hostname
    assert_equal 'target2_command', tm2.command
    assert_equal 'CP-350', tm2.encoding
    assert_equal 6, tm2.duration
    assert_equal 2, tm2.id
    assert_equal 2.5, tm2.weight
    assert_equal true, tm2.check
    assert_equal 'target2_result', tm2.result
    assert_equal 'target2_alterations', tm2.alterations
    assert_equal 'target2_expected', tm2.expected
  end
end
