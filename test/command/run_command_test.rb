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
      # 12-preserve",
      "13-feedback",
      "14-moodle_id",
      "15-readme",
      "16-include",
      "17-alias",
      "18-log",
      "19-read_vars",
      # "20-macros",
      "21-exit_codes",
      "22-result",
      "23-test-code"
    ]
    filedirname = File.dirname(__FILE__)
    @dirbase = File.join(filedirname, "..", "..", "examples")
  end

  def test_run_examples
    puts ""
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
