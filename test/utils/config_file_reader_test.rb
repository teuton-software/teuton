require "test/unit"
require_relative "../../lib/teuton/utils/config_file_reader"

class ConfigFileReaderTest < Test::Unit::TestCase
  def test_t01_read_yaml_config_with_strings
    filepath = File.join("test", "files", "t01-read-config", "demo.yaml")
    data = ConfigFileReader.read(filepath)
    assert_equal({}, data[:global])
    assert_equal 1, data[:cases].size
    assert_equal Hash, data[:cases][0].class
    assert_equal "student_1", data[:cases][0][:tt_members]
  end

  def test_t02_read_yaml_config_with_symbols
    filepath = File.join("test", "files", "t02-read-config", "config.yaml")
    data = ConfigFileReader.read(filepath)
    assert_equal({}, data[:global])
    assert_equal 2, data[:cases].size
    assert_equal Hash, data[:cases][0].class
    assert_equal "student_1", data[:cases][0][:tt_members]
    assert_equal "student_2", data[:cases][1][:tt_members]
  end

  def test_t03_read_yaml_config_and_include_yaml_files
    filepath = File.join("test", "files", "t03-read-yaml", "config.yaml")
    data = ConfigFileReader.read(filepath)
    assert_equal([:tt_include], data[:global].keys)
    assert_equal 3, data[:cases].size
    assert_equal Hash, data[:cases][0].class
    assert_equal "student_1", data[:cases][0][:tt_members]
    assert_equal "student_2", data[:cases][1][:tt_members]
    assert_equal "student_3", data[:cases][2][:tt_members]
  end

  def test_t04_read_json_config
    filepath = File.join("test", "files", "t04-read-json", "demo.json")
    data = ConfigFileReader.read(filepath)
    assert_equal({}, data[:global])
    assert_equal 4, data[:cases].size
    assert_equal Hash, data[:cases][0].class
    assert_equal "student_1", data[:cases][0][:tt_members]
    assert_equal "student_2", data[:cases][1][:tt_members]
    assert_equal "student_3", data[:cases][2][:tt_members]
    assert_equal "student_4", data[:cases][3][:tt_members]
  end

  def test_t05_read_json_config_and_include_json_files
    filepath = File.join("test", "files", "t05-read-json", "config.json")
    data = ConfigFileReader.read(filepath)
    assert_equal([:tt_include], data[:global].keys)
    assert_equal 5, data[:cases].size
    assert_equal Hash, data[:cases][0].class
    assert_equal "student_1", data[:cases][0][:tt_members]
    assert_equal "student_2", data[:cases][1][:tt_members]
    assert_equal "student_3", data[:cases][2][:tt_members]
    assert_equal "student_4", data[:cases][3][:tt_members]
    assert_equal "student_5", data[:cases][4][:tt_members]
  end
end
