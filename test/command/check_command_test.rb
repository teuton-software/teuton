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
      "07-debug",
      "09-preserve",
      "09-send",
      "11-moodle_id",
      "12-get_vars",
      "13-include",
      "14-alias",
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
      assert_equal true, system(cmd)
    end
  end
end
