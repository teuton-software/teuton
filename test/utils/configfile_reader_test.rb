#!/usr/bin/env ruby

require "test/unit"
require_relative "../../lib/teuton/utils/configfile_reader"

# MiniTest for ConfigFileReader Class
class ConfigFileReaderTest < Test::Unit::TestCase
  def test_read
    data = ConfigFileReader.read("test/files/example-01.yaml")
    assert_equal({}, data[:global])
    assert_equal 1, data[:cases].size
    assert_equal Hash, data[:cases][0].class
    assert_equal "student1", data[:cases][0][:tt_members]

    data = ConfigFileReader.read("test/files/example-03/config.yaml")
    assert_equal({}, data[:global])
    assert_equal 1, data[:cases].size
    assert_equal Hash, data[:cases][0].class
    assert_equal "student1", data[:cases][0][:tt_members]

    data = ConfigFileReader.read("test/files/example-04.json")
    assert_equal({}, data[:global])
    assert_equal 1, data[:cases].size
    assert_equal Hash, data[:cases][0].class
    assert_equal "student1", data[:cases][0][:tt_members]
  end
end
