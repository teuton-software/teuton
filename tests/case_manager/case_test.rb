#!/usr/bin/env ruby

require 'minitest/autorun'
require_relative '../../lib/case_manager/case'

# MiniTest Case Class
class CaseTest < Minitest::Test
  def setup
    @app = Application.instance
    @app.reset
    @app.global = { :tt_testname => 'demo'}
    @case = Case.new({})
  end

  def test_initialize
    assert_equal 0, @case.action[:id]
    assert_equal 1.0, @case.action[:weight]
    assert_equal 'No description!', @case.action[:description]
    assert_equal [], @case.uniques
    id = @case.id
    assert_equal "case-0#{@case.id}", @case.report.filename
    assert_equal File.join('var','demo','out'), @case.report.output_dir
  end

  def test_target
    @case.target
    assert_equal 'No description!', @case.target
    assert_equal 'No description!', @case.goal
    @case.target 'Target 1 description'
    assert_equal 'Target 1 description', @case.target
    assert_equal 'Target 1 description', @case.goal
    @case.target asset: 'assets/README.md'
    assert_equal 'assets/README.md', @case.target
  end

  def test_weigth
    assert_equal 1.0, @case.weight
    @case.weight(2.5)
    assert_equal 2.5, @case.weight
    @case.weight(:default)
    assert_equal 1.0, @case.weight
  end
end
