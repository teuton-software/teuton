#!/usr/bin/env ruby

require 'minitest/autorun'
require_relative '../../lib/teuton/project/configfile_reader'

# MiniTest for ConfigFileReader Class
class ConfigFileReaderTest < Minitest::Test
  def test_read
    data = ConfigFileReader.read('tests/files/example-01.yaml')
    assert_equal Hash.new, data[:global]
    assert_equal 1, data[:cases].size
    assert_equal Hash, data[:cases][0].class
    assert_equal 'student1', data[:cases][0][:tt_members]

    data = ConfigFileReader.read('tests/files/example-03/config.yaml')
    assert_equal Hash.new, data[:global]
    assert_equal 1, data[:cases].size
    assert_equal Hash, data[:cases][0].class
    assert_equal 'student1', data[:cases][0][:tt_members]

    data = ConfigFileReader.read('tests/files/example-04.json')
    assert_equal Hash.new, data[:global]
    assert_equal 1, data[:cases].size
    assert_equal Hash, data[:cases][0].class
    assert_equal 'student1', data[:cases][0][:tt_members]
  end
end
