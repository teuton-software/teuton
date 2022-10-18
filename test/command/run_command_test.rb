#!/usr/bin/ruby

require "test/unit"

class RunCommandTest < Test::Unit::TestCase
  def setup
    @examples = [
      "learn-01-target",
      "learn-02-config",
      "learn-07-log",
      "learn-08-readme",
      # "learn-09-preserve",
      "learn-10-result_and_moodle_id"
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
