#!/usr/bin/env ruby

require 'minitest/autorun'
require_relative '../../lib/project/project'
require_relative '../../lib/application'

# MiniTest for Project Class
class ProjectTest < Minitest::Test
  def test_find_filenames_for
    app = Application.instance
    app.verbose = false
    # Simple mode, files exists
    basedir = app.running_basedir

    Project.find_filenames_for('tests/files/example-01.rb')
    a = File.join(basedir, 'tests/files')
    b = File.join(basedir, 'tests/files/example-01.rb')
    c = File.join(basedir, 'tests/files/example-01.yaml')
    assert_equal a, app.project_path
    assert_equal b, app.script_path
    assert_equal c, app.config_path
    assert_equal 'example-01', app.test_name

    # Complex mode, dir empty
    Project.find_filenames_for('tests/files/example-02')
    a = File.join(basedir,'tests/files/example-02/start.rb')
    b = File.join(basedir,'tests/files/example-02/config.yaml')
    assert_equal a, app.script_path
    assert_equal b, app.config_path
    assert_equal 'example-02', app.test_name

    # Complex mode, files exists
    Project.find_filenames_for('tests/files/example-03')
    a = File.join(basedir,'tests/files/example-03/start.rb')
    b = File.join(basedir,'tests/files/example-03/config.yaml')
    assert_equal a, app.script_path
    assert_equal b, app.config_path
    assert_equal 'example-03', app.test_name

    # Simple mode, files exists with JSON
    Project.find_filenames_for('tests/files/example-04.rb')
    a = File.join(basedir,'tests/files/example-04.rb')
    b = File.join(basedir,'tests/files/example-04.json')
    assert_equal a, app.script_path
    assert_equal b, app.config_path
    assert_equal 'example-04', app.test_name

    # Complex mode, files exists with JSON
    Project.find_filenames_for('tests/files/example-05')
    a = File.join(basedir,'tests/files/example-05/start.rb')
    b = File.join(basedir,'tests/files/example-05/config.json')
    assert_equal a, app.script_path
    assert_equal b, app.config_path
    assert_equal 'example-05', app.test_name
    app.verbose = true
  end
end
