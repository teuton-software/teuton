require "test/unit"

class ReadmeCommandTest < Test::Unit::TestCase
  def setup
    @examples = [
      "01-cmd_new",
      "02-target",
      "03-remote_hosts",
      "04-config",
      "05-use",
      "07-target_weight",
      "08-unique_values",
      "09-send",
      "10-debug",
      "11-export",
      "12-preserve",
      "13-feedback",
      "14-moodle_id",
      "15-readme",
      "16-include",
      "17-alias",
      "18-log",
      "19-read_vars",
      # "20-macros"
      "21-exit_codes",
      "22-result"
    ]
    filedirname = File.dirname(__FILE__)
    @dirbase = File.join(filedirname, "..", "..", "examples")
  end

  def test_readme_examples
    @examples.each do |name|
      dir = File.join(@dirbase, name)
      cmd = "teuton readme #{dir} > /dev/null"
      puts "=> readme: #{name}"
      assert_equal true, system(cmd)
    end
  end
end
