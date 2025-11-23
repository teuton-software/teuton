require "test/unit"
require_relative "../../lib/teuton/utils/project"
require_relative "../../lib/teuton/utils/name_file_finder"

class NameFileFinderTest < Test::Unit::TestCase
  def test_relpath_simple_mode_find_filenames_for
    Project.value[:verbose] = false

    # Simple mode, files exists
    dirpath = File.join("test", "files", "t01-read-config")
    finder = NameFileFinder.new
    finder.find_filenames_for(File.join(dirpath, "demo.rb"))

    basedir = Project.value[:running_basedir]
    a = File.join(basedir, dirpath)
    b = File.join(basedir, dirpath, "demo.rb")
    c = File.join(basedir, dirpath, "demo.yaml")
    assert_equal a, finder.project_path
    assert_equal b, finder.script_path
    assert_equal c, finder.config_path
    assert_equal "demo", finder.test_name

    Project.value[:verbose] = true
  end

  def test_abspath_simple_mode_find_filenames_for
    Project.value[:verbose] = false

    # Simple mode, files exists (using absolute path)
    dirpath = File.join("test", "files", "t01-read-config")
    basedir = Project.value[:running_basedir]
    absolute_path = File.join(basedir, dirpath, "demo.rb")
    finder = NameFileFinder.new
    finder.find_filenames_for(absolute_path)
    a = File.join(basedir, dirpath)
    b = File.join(basedir, dirpath, "demo.rb")
    c = File.join(basedir, dirpath, "demo.yaml")
    assert_equal a, finder.project_path
    assert_equal b, finder.script_path
    assert_equal c, finder.config_path
    assert_equal "demo", finder.test_name

    Project.value[:verbose] = true
  end

  def test_complex_mode_dir_empty
    Project.value[:verbose] = false

    # Complex mode, dir empty
    dirpath = File.join("test", "files", "t02-read-config")
    finder = NameFileFinder.new
    finder.find_filenames_for(dirpath)
    basedir = Project.value[:running_basedir]
    a = File.join(basedir, dirpath)
    b = File.join(basedir, dirpath, "start.rb")
    c = File.join(basedir, dirpath, "config.yaml")
    assert_equal a, finder.project_path
    assert_equal b, finder.script_path
    assert_equal c, finder.config_path
    assert_equal "t02-read-config", finder.test_name

    Project.value[:verbose] = true
  end

  def test_complex_mode_files_exist
    Project.value[:verbose] = false

    # Complex mode, files exist
    dirpath = File.join("test", "files", "t03-read-yaml")
    finder = NameFileFinder.new
    finder.find_filenames_for(dirpath)
    basedir = Project.value[:running_basedir]
    a = File.join(basedir, dirpath)
    b = File.join(basedir, dirpath, "start.rb")
    c = File.join(basedir, dirpath, "config.yaml")
    assert_equal a, finder.project_path
    assert_equal b, finder.script_path
    assert_equal c, finder.config_path
    assert_equal "t03-read-yaml", finder.test_name

    Project.value[:verbose] = true
  end

  def test_json_simple_mode_find_filenames_for
    Project.value[:verbose] = false

    # Simple mode, files exists with JSON
    dirpath = File.join("test", "files", "t04-read-json")
    finder = NameFileFinder.new
    finder.find_filenames_for(File.join(dirpath, "demo.rb"))
    basedir = Project.value[:running_basedir]
    a = File.join(basedir, dirpath)
    b = File.join(basedir, dirpath, "demo.rb")
    c = File.join(basedir, dirpath, "demo.json")
    assert_equal a, finder.project_path
    assert_equal b, finder.script_path
    assert_equal c, finder.config_path
    assert_equal "demo", finder.test_name

    Project.value[:verbose] = true
  end

  def test_complex_mode_files_exist_with_json
    Project.value[:verbose] = false

    # Complex mode, files exists with JSON
    dirpath = File.join("test", "files", "t05-read-json")
    finder = NameFileFinder.new
    finder.find_filenames_for(dirpath)
    basedir = Project.value[:running_basedir]
    a = File.join(basedir, dirpath)
    b = File.join(basedir, dirpath, "start.rb")
    c = File.join(basedir, dirpath, "config.json")
    assert_equal a, finder.project_path
    assert_equal b, finder.script_path
    assert_equal c, finder.config_path
    assert_equal "t05-read-json", finder.test_name

    Project.value[:verbose] = true
  end
end
