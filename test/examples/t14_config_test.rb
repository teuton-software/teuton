require "test/unit"
require "yaml"

class T14configTest < Test::Unit::TestCase
  def setup
    @dirbase = File.join("test", "files")
    @filepath = File.join(@dirbase, "t14-config")
  end

  def test_example_test_02_config
    filepath = @filepath
    configfile = File.join(filepath, "config.yaml")
    testname, _resume, data = execute_teuton_test filepath

    assert_equal File.join(filepath, "start.rb"), data[:config][:tt_scriptname]
    assert_equal testname, data[:config][:tt_testname]
    assert_equal configfile, data[:config][:tt_configfile]

    assert_equal 2, data[:cases].size

    assert_equal false, data[:cases][0][:skip]
    assert_equal "01", data[:cases][0][:id]
    assert_equal 100, data[:cases][0][:grade]
    assert_equal "Student-name-1", data[:cases][0][:members]
    assert_equal({}, data[:cases][0][:conn_status])
    assert_equal "NODATA", data[:cases][0][:moodle_id]

    assert_equal false, data[:cases][1][:skip]
    assert_equal "02", data[:cases][1][:id]
    assert_equal 0.0, data[:cases][1][:grade]
    assert_equal "Student-name-2", data[:cases][1][:members]
    assert_equal({}, data[:cases][1][:conn_status])
    assert_equal "NODATA", data[:cases][1][:moodle_id]
  end

  def test_example_test_02_config_with_cname_rock
    filepath = @filepath
    configfile = File.join(filepath, "rock.yaml")
    testname, _resume, data = execute_teuton_test(filepath, "--cname=rock")

    assert_equal File.join(filepath, "start.rb"), data[:config][:tt_scriptname]
    assert_equal testname, data[:config][:tt_testname]
    assert_equal configfile, data[:config][:tt_configfile]

    assert_equal 2, data[:cases].size

    assert_equal false, data[:cases][0][:skip]
    assert_equal "01", data[:cases][0][:id]
    assert_equal 100, data[:cases][0][:grade]
    assert_equal "Rock and roll", data[:cases][0][:members]
    assert_equal({}, data[:cases][0][:conn_status])
    assert_equal "NODATA", data[:cases][0][:moodle_id]

    assert_equal false, data[:cases][1][:skip]
    assert_equal "02", data[:cases][1][:id]
    assert_equal 0.0, data[:cases][1][:grade]
    assert_equal "AC/DC", data[:cases][1][:members]
    assert_equal({}, data[:cases][1][:conn_status])
    assert_equal "NODATA", data[:cases][1][:moodle_id]
  end

  def test_example_learn_02_config_with_cpath_starwars
    filepath = @filepath
    configfile = File.join(filepath, "starwars.yaml")
    testname, _resume, data = execute_teuton_test(filepath, "--cpath=#{configfile}")

    assert_equal File.join(filepath, "start.rb"), data[:config][:tt_scriptname]
    assert_equal testname, data[:config][:tt_testname]
    assert_equal configfile, data[:config][:tt_configfile]

    assert_equal 2, data[:cases].size

    assert_equal false, data[:cases][0][:skip]
    assert_equal "01", data[:cases][0][:id]
    assert_equal 100, data[:cases][0][:grade]
    assert_equal "Yoda", data[:cases][0][:members]
    assert_equal({}, data[:cases][0][:conn_status])
    assert_equal "NODATA", data[:cases][0][:moodle_id]

    assert_equal false, data[:cases][1][:skip]
    assert_equal "02", data[:cases][1][:id]
    assert_equal 0.0, data[:cases][1][:grade]
    assert_equal "Darth Maul", data[:cases][1][:members]
    assert_equal({}, data[:cases][1][:conn_status])
    assert_equal "NODATA", data[:cases][1][:moodle_id]
  end

  private

  def execute_teuton_test(filepath, options = "")
    cmd = "./teuton run #{options} --no-color --export=yaml #{filepath} > /dev/null"
    system(cmd)
    testname = File.basename(filepath)
    filepath = File.join("var", testname, "resume.yaml")
    data = YAML.unsafe_load(File.read(filepath))
    [testname, filepath, data]
  end

  def read_case_report(id, testname)
    filepath = File.join("var", testname, "case-#{id}.yaml")
    YAML.unsafe_load(File.read(filepath))
  end
end
