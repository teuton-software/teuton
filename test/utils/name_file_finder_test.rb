#!/usr/bin/env ruby

require "minitest/autorun"
require_relative "../../lib/teuton/utils/name_file_finder"
require_relative "../../lib/teuton/application"

# MiniTest for Project Class
class NameFileFinderTest < Minitest::Test
  def test_relpath_simple_mode_find_filenames_for
    app = Application.instance
    app.verbose = false

    # Simple mode, files exists
    NameFileFinder.find_filenames_for("tests/files/example-01.rb")
    basedir = app.running_basedir
    a = File.join(basedir, "tests/files")
    b = File.join(basedir, "tests/files/example-01.rb")
    c = File.join(basedir, "tests/files/example-01.yaml")
    assert_equal a, app.project_path
    assert_equal b, app.script_path
    assert_equal c, app.config_path
    assert_equal "example-01", app.test_name
  end

  def test_abspath_simple_mode_find_filenames_for
    app = Application.instance
    app.verbose = false

    # Simple mode, files exists (using absolute path)
    basedir = app.running_basedir
    absolute_path = File.join(basedir, "tests/files/example-01.rb")
    NameFileFinder.find_filenames_for(absolute_path)
    b = File.join(basedir, "tests/files/example-01.rb")
    c = File.join(basedir, "tests/files/example-01.yaml")
    assert_equal a, app.project_path
    assert_equal b, app.script_path
    assert_equal c, app.config_path
    assert_equal "example-01", app.test_name
  end

  def test_json_simple_mode_find_filenames_for
    app = Application.instance
    app.verbose = false

    # Simple mode, files exists with JSON
    NameFileFinder.find_filenames_for("tests/files/example-04.rb")
    basedir = app.running_basedir
    a = File.join(basedir, "tests/files")
    b = File.join(basedir, "tests/files/example-04.rb")
    c = File.join(basedir, "tests/files/example-04.json")
    assert_equal a, app.project_path
    assert_equal b, app.script_path
    assert_equal c, app.config_path
    assert_equal "example-04", app.test_name
  end

  def test_complex_mode_find_filenames_for
    app = Application.instance
    app.verbose = false

    # Complex mode, dir empty
    NameFileFinder.find_filenames_for("tests/files/example-02")
    basedir = app.running_basedir
    a = File.join(basedir, "tests/files/example-02")
    b = File.join(basedir, "tests/files/example-02/start.rb")
    c = File.join(basedir, "tests/files/example-02/config.yaml")
    assert_equal a, app.project_path
    assert_equal b, app.script_path
    assert_equal c, app.config_path
    assert_equal "example-02", app.test_name

    # Complex mode, files exists
    NameFileFinder.find_filenames_for("tests/files/example-03")
    basedir = app.running_basedir
    a = File.join(basedir, "tests/files/example-03")
    b = File.join(basedir, "tests/files/example-03/start.rb")
    c = File.join(basedir, "tests/files/example-03/config.yaml")
    assert_equal a, app.project_path
    assert_equal b, app.script_path
    assert_equal c, app.config_path
    assert_equal "example-03", app.test_name

    # Complex mode, files exists with JSON
    NameFileFinder.find_filenames_for("tests/files/example-05")
    basedir = app.running_basedir
    a = File.join(basedir, "tests/files/example-05")
    b = File.join(basedir, "tests/files/example-05/start.rb")
    c = File.join(basedir, "tests/files/example-05/config.json")
    assert_equal a, app.project_path
    assert_equal b, app.script_path
    assert_equal c, app.config_path
    assert_equal "example-05", app.test_name
    app.verbose = true
  end
end
