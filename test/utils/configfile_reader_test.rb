require "test/unit"
require_relative "../../lib/teuton/utils/configfile_reader"

class ConfigFileReaderTest < Test::Unit::TestCase
  def test_t01_read_config
    filepath = File.join("test", "files", "t01-read-config", "demo.yaml")
    data = ConfigFileReader.read(filepath)
    assert_equal({}, data[:global])
    assert_equal 1, data[:cases].size
    assert_equal Hash, data[:cases][0].class
    assert_equal "student1", data[:cases][0][:tt_members]
  end

  def test_t03_read_yaml
    filepath = File.join("test", "files", "t03-read-yaml", "config.yaml")
    data = ConfigFileReader.read(filepath)
    assert_equal({}, data[:global])
    assert_equal 1, data[:cases].size
    assert_equal Hash, data[:cases][0].class
    assert_equal "student1", data[:cases][0][:tt_members]
  end

  def test_t04_read_json
    filepath = File.join("test", "files", "t04-read-json", "demo.json")
    data = ConfigFileReader.read(filepath)
    assert_equal({}, data[:global])
    assert_equal 1, data[:cases].size
    assert_equal Hash, data[:cases][0].class
    assert_equal "student1", data[:cases][0][:tt_members]
  end
end
