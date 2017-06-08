#!/usr/bin/ruby

require 'minitest/autorun'
require_relative '../lib/project'
require_relative '../lib/application'

# MiniTest for Project Class
class ProjectTest < Minitest::Test
  def test_find_filenames_for
    Application.instance.verbose = false
    script_path, config_path, test_name = Project.find_filenames_for('tests/files/example-01.rb')
    assert_equal 'tests/files/example-01.rb', script_path
    assert_equal 'tests/files/example-01.yaml', config_path
    assert_equal 'example-01', test_name

    script_path, config_path, test_name = Project.find_filenames_for('tests/files/example-02')
    assert_equal 'tests/files/example-02/start.rb', script_path
    assert_equal 'tests/files/example-02/config.yaml', config_path
    assert_equal 'example-02', test_name
    Application.instance.verbose = true
  end
end
