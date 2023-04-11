require "test/unit"
require_relative "../../lib/teuton/utils/project"
require_relative "../../lib/teuton/utils/name_file_finder"

class NameFileFinderTest < Test::Unit::TestCase
  def test_relpath_simple_mode_find_filenames_for
    Project.value[:verbose] = false

    # Simple mode, files exists
    finder = NameFileFinder.new
    finder.find_filenames_for("test/files/example-01.rb")

    basedir = Project.value[:running_basedir]
    a = File.join(basedir, "test/files")
    b = File.join(basedir, "test/files/example-01.rb")
    c = File.join(basedir, "test/files/example-01.yaml")
    assert_equal a, finder.project_path
    assert_equal b, finder.script_path
    assert_equal c, finder.config_path
    assert_equal "example-01", finder.test_name

    Project.value[:verbose] = true
  end

  def test_abspath_simple_mode_find_filenames_for
    Project.value[:verbose] = false

    # Simple mode, files exists (using absolute path)
    basedir = Project.value[:running_basedir]
    absolute_path = File.join(basedir, "test/files/example-01.rb")
    finder = NameFileFinder.new
    finder.find_filenames_for(absolute_path)
    a = File.join(basedir, "test/files")
    b = File.join(basedir, "test/files/example-01.rb")
    c = File.join(basedir, "test/files/example-01.yaml")
    assert_equal a, finder.project_path
    assert_equal b, finder.script_path
    assert_equal c, finder.config_path
    assert_equal "example-01", finder.test_name

    Project.value[:verbose] = true
  end

  def test_json_simple_mode_find_filenames_for
    Project.value[:verbose] = false

    # Simple mode, files exists with JSON
    finder = NameFileFinder.new
    finder.find_filenames_for("test/files/example-04.rb")
    basedir = Project.value[:running_basedir]
    a = File.join(basedir, "test/files")
    b = File.join(basedir, "test/files/example-04.rb")
    c = File.join(basedir, "test/files/example-04.json")
    assert_equal a, finder.project_path
    assert_equal b, finder.script_path
    assert_equal c, finder.config_path
    assert_equal "example-04", finder.test_name

    Project.value[:verbose] = true
  end

  def test_complex_mode_dir_empty
    Project.value[:verbose] = false

    # Complex mode, dir empty
    finder = NameFileFinder.new
    finder.find_filenames_for("test/files/example-02")
    basedir = Project.value[:running_basedir]
    a = File.join(basedir, "test/files/example-02")
    b = File.join(basedir, "test/files/example-02/start.rb")
    c = File.join(basedir, "test/files/example-02/config.yaml")
    assert_equal a, finder.project_path
    assert_equal b, finder.script_path
    assert_equal c, finder.config_path
    assert_equal "example-02", finder.test_name

    Project.value[:verbose] = true
  end

  def test_complex_mode_files_exist
    Project.value[:verbose] = false

    # Complex mode, files exist
    finder = NameFileFinder.new
    finder.find_filenames_for("test/files/example-03")
    basedir = Project.value[:running_basedir]
    a = File.join(basedir, "test/files/example-03")
    b = File.join(basedir, "test/files/example-03/start.rb")
    c = File.join(basedir, "test/files/example-03/config.yaml")
    assert_equal a, finder.project_path
    assert_equal b, finder.script_path
    assert_equal c, finder.config_path
    assert_equal "example-03", finder.test_name

    Project.value[:verbose] = true
  end

  def test_complex_mode_files_exist_with_json
    Project.value[:verbose] = false

    # Complex mode, files exists with JSON
    finder = NameFileFinder.new
    finder.find_filenames_for("test/files/example-05")
    basedir = Project.value[:running_basedir]
    a = File.join(basedir, "test/files/example-05")
    b = File.join(basedir, "test/files/example-05/start.rb")
    c = File.join(basedir, "test/files/example-05/config.json")
    assert_equal a, finder.project_path
    assert_equal b, finder.script_path
    assert_equal c, finder.config_path
    assert_equal "example-05", finder.test_name

    Project.value[:verbose] = true
  end
end
