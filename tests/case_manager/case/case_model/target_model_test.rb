#!/usr/bin/env ruby

require 'minitest/autorun'
require_relative '../../../../lib/case_manager/case/case_model/target_model'

# MiniTest TargetModel Class
class TargetModelTest < Minitest::Test
  def setup
    @tm1 = CaseModel::TargetModel.new()
    @tm2 = CaseModel::TargetModel.new('target2_desc', :asset => 'README.md')
    @tm2.hostname = 'target2_hostname'
    @tm2.command = 'target2_command'
    @tm2.encoding = 'CP-350'
    @tm2.duration = 6
    @tm2.id = 2
    @tm2.weight = 2.5
    @tm2.check = true
    @tm2.result = 'target2_result'
    @tm2.alterations = 'target2_alterations'
    @tm2.expected = 'target2_expected'
  end

  def test_target_model1
    assert_equal 'No description!', @tm1.description
    assert_nil @tm1.asset
    assert_equal '', @tm1.hostname
    assert_equal '', @tm1.command
    assert_equal 'UTF-8', @tm1.encoding
    assert_equal 0, @tm1.duration
    assert_equal 0, @tm1.id
    assert_equal 1.0, @tm1.weight
    assert_equal false, @tm1.check
    assert_equal '', @tm1.result
    assert_equal '', @tm1.alterations
    assert_equal '', @tm1.expected
  end

  def test_target_model2
    assert_equal 'target2_desc', @tm2.description
    assert_equal 'README.md', @tm2.asset
    assert_equal 'target2_hostname', @tm2.hostname
    assert_equal 'target2_command', @tm2.command
    assert_equal 'CP-350', @tm2.encoding
    assert_equal 6, @tm2.duration
    assert_equal 2, @tm2.id
    assert_equal 2.5, @tm2.weight
    assert_equal true, @tm2.check
    assert_equal 'target2_result', @tm2.result
    assert_equal 'target2_alterations', @tm2.alterations
    assert_equal 'target2_expected', @tm2.expected
  end
end
