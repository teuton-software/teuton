#!/usr/bin/ruby

require "test/unit"

class RunCommandTest < Test::Unit::TestCase
  def setup
    @examples = [
      "02-target",
      "02-config",
      "07-log",
      "08-readme",
      # "learn-09-preserve",
      "10-result",
      "11-moodle_id",
      "12-get_vars",
      "13-include",
      "14-alias",
      # "15-macros",
      "16-exit_codes"
    ]
    filedirname = File.dirname(__FILE__)
    @dirbase = File.join(filedirname, "..", "..", "examples")
  end

  def test_run_examples
    @examples.each do |name|
      dir = File.join(@dirbase, name)

      cmd = "teuton run --quiet #{dir} > /dev/null"
      assert_equal true, system(cmd)

      cmd = "teuton #{dir} > /dev/null"
      assert_equal true, system(cmd)
    end
  end
end
