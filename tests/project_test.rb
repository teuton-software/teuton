#!/usr/bin/ruby

require 'minitest/autorun'
require_relative '../lib/project'
require_relative '../lib/application'

# MiniTest for Project Class
class ProjectTest < Minitest::Test
  def test_find_filenames_for
    app = Application.instance
    app.verbose = false
    # Simple mode, files exists
    Project.find_filenames_for('tests/files/example-01.rb')
    assert_equal 'tests/files/example-01.rb', app.script_path
    assert_equal 'tests/files/example-01.yaml', app.config_path
    assert_equal 'example-01', app.test_name

    # Complex mode, dir empty
    Project.find_filenames_for('tests/files/example-02')
    assert_equal 'tests/files/example-02/start.rb', app.script_path
    assert_equal 'tests/files/example-02/config.yaml', app.config_path
    assert_equal 'example-02', app.test_name

    # Complex mode, files exists
    Project.find_filenames_for('tests/files/example-03')
    assert_equal 'tests/files/example-03/start.rb', app.script_path
    assert_equal 'tests/files/example-03/config.yaml', app.config_path
    assert_equal 'example-03', app.test_name

    # Simple mode, files exists with JSON
    Project.find_filenames_for('tests/files/example-04.rb')
    assert_equal 'tests/files/example-04.rb', app.script_path
    assert_equal 'tests/files/example-04.json', app.config_path
    assert_equal 'example-04', app.test_name

    # Complex mode, files exists with JSON
    Project.find_filenames_for('tests/files/example-05')
    assert_equal 'tests/files/example-05/start.rb', app.script_path
    assert_equal 'tests/files/example-05/config.json', app.config_path
    assert_equal 'example-05', app.test_name
    app.verbose = true
  end
end
