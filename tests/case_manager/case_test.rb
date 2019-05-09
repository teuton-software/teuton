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
    assert_equal 1, @case.id
    assert_equal '01', @case.id_to_s
    assert_equal 0, @case.action[:id]
    assert_equal 1.0, @case.action[:weight]
    assert_equal 'No description!', @case.action[:description]
    assert_equal [], @case.uniques
    assert_equal 'case-01', @case.report.filename
    assert_equal File.join('var','demo','out'), @case.report.output_dir
  end

end
