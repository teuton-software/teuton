require "test/unit"

class CheckCommandTest < Test::Unit::TestCase
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
      "12-get_vars",
      "12-preserve",
      "13-include",
      "14-alias",
      "14-moodle_id",
      # "15-macros",
      "15-readme",
      "16-exit_codes",
      "18-log",
      "23-result"
    ]
    filedirname = File.dirname(__FILE__)
    @dirbase = File.join(filedirname, "..", "..", "examples")
  end

  def test_check_examples
    @examples.each do |name|
      dir = File.join(@dirbase, name)
      cmd = "teuton check #{dir} > /dev/null"
      puts "=> check: #{name}"
      assert_equal true, system(cmd)
    end
  end
end
