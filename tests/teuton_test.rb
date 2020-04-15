#!/usr/bin/env ruby

require 'minitest/autorun'
require 'yaml'

# MiniTest Rubocop
class TeutonTest < Minitest::Test
  def setup
    @files = []
    @files << 'examples/learn-01-target'
  end

  def test_learn_01_target
    filepath = 'examples/learn-01-target'
    system("teuton run --no-color --export=yaml #{filepath} > /dev/null")
    testname = File.basename(filepath)
    resume = File.join('var', testname, 'resume.yaml')
    data = YAML.load(File.read(resume))

    assert_equal File.join(filepath, 'start.rb'), data[:config][:tt_scriptname]
    assert_equal testname, data[:config][:tt_testname]

    assert_equal 1, data[:cases].size
    assert_equal false, data[:cases][0][:skip]
    assert_equal '01', data[:cases][0][:id]
    assert_equal 100, data[:cases][0][:grade]
    assert_equal 'anonymous', data[:cases][0][:members]
    assert_equal Hash.new, data[:cases][0][:conn_status]
  end
end
