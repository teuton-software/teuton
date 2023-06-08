require "test/unit"
require "yaml"

class Examples01Test < Test::Unit::TestCase
  def setup
    @dirbase = File.join("test", "files")
    @filepath = File.join(@dirbase, "test-01-target")
  end

  def test_example_test_01_target
    filepath = @filepath
    testname, _resume, data = execute_teuton_test filepath

    assert_equal File.join(filepath, "start.rb"), data[:config][:tt_scriptname]
    assert_equal testname, data[:config][:tt_testname]

    assert_equal 1, data[:cases].size
    assert_equal false, data[:cases][0][:skip]
    assert_equal "01", data[:cases][0][:id]
    assert_equal 100, data[:cases][0][:grade]
    assert_equal "anonymous", data[:cases][0][:members]
    assert_equal({}, data[:cases][0][:conn_status])
    assert_equal "NODATA", data[:cases][0][:moodle_id]

    data = read_case_report("01", testname)
    targets = data[:groups][0][:targets]
    assert_equal "01", targets[0][:target_id]
    assert_equal true, targets[0][:check]
    assert_equal 1.0, targets[0][:score]
    assert_equal 1.0, targets[0][:weight]
    assert_equal "Create user root", targets[0][:description]
    assert_equal "id root 2>/dev/null", targets[0][:command]
    assert_equal :local, targets[0][:conn_type]
    assert_equal "find(root) & count", targets[0][:alterations]
    assert_equal "Greater than 0", targets[0][:expected]
    assert_equal 1, targets[0][:result]
  end

  private

  def execute_teuton_test(filepath, options = "")
    cmd = "teuton run #{options} --no-color --export=yaml #{filepath} > /dev/null"
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
