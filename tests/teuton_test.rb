#!/usr/bin/env ruby

require 'minitest/autorun'
require 'yaml'

# MiniTest Rubocop
class TeutonTest < Minitest::Test
  def setup
  end

  def execute_teuton_test(filepath)
    system("teuton run --no-color --export=yaml #{filepath} > /dev/null")
    testname = File.basename(filepath)
    resume = File.join('var', testname, 'resume.yaml')
    data = YAML.load(File.read(resume))
    [ testname, resume, data ]
  end

  def test_learn_01_target
    filepath = 'examples/learn-01-target'
    testname, resume, data = execute_teuton_test filepath

    assert_equal File.join(filepath, 'start.rb'), data[:config][:tt_scriptname]
    assert_equal testname, data[:config][:tt_testname]

    assert_equal 1, data[:cases].size
    assert_equal false, data[:cases][0][:skip]
    assert_equal '01', data[:cases][0][:id]
    assert_equal 100, data[:cases][0][:grade]
    assert_equal 'anonymous', data[:cases][0][:members]
    assert_equal Hash.new, data[:cases][0][:conn_status]
    assert_equal 'NODATA', data[:cases][0][:moodle_id]
  end

  def test_learn_02_config
    filepath = 'examples/learn-02-config'
    testname, resume, data = execute_teuton_test filepath

    assert_equal File.join(filepath, 'start.rb'), data[:config][:tt_scriptname]
    assert_equal testname, data[:config][:tt_testname]

    assert_equal 2, data[:cases].size

    assert_equal false, data[:cases][0][:skip]
    assert_equal '01', data[:cases][0][:id]
    assert_equal 100, data[:cases][0][:grade]
    assert_equal 'Student-name-1', data[:cases][0][:members]
    assert_equal Hash.new, data[:cases][0][:conn_status]
    assert_equal 'NODATA', data[:cases][0][:moodle_id]

    assert_equal false, data[:cases][1][:skip]
    assert_equal '02', data[:cases][1][:id]
    assert_equal 0.0, data[:cases][1][:grade]
    assert_equal 'Student-name-2', data[:cases][1][:members]
    assert_equal Hash.new, data[:cases][1][:conn_status]
    assert_equal 'NODATA', data[:cases][1][:moodle_id]
  end
  
end
