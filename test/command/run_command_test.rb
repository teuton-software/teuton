#!/usr/bin/ruby

require "test/unit"

class RunCommandTest < Test::Unit::TestCase
  def setup
    @examples = [
      "02-target",
      # "04-config",
      # "05-use",
      # "07-target_weight",
      # "08-unique_values",
      # "09-send",
      # "10-debug",
      "11-export",
      "12-get_vars",
      # "12-preserve",
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

  def test_run_examples
    @examples.each do |name|
      dir = File.join(@dirbase, name)
      puts "=> run: #{name}"

      cmd = "teuton run --quiet #{dir} > /dev/null"
      assert_equal true, system(cmd)

      cmd = "teuton #{dir} > /dev/null"
      assert_equal true, system(cmd)
    end
  end
end
