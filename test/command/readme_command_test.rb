#!/usr/bin/ruby

require "test/unit"

class ReadmeCommandTest < Test::Unit::TestCase
  def setup
    @examples = [
      "learn-01-target",
      "learn-02-config",
      "learn-03-remote_hosts",
      "learn-04-new_test",
      "learn-05-use",
      "learn-06-debug",
      "learn-07-log",
      "learn-08-readme",
      "learn-09-preserve",
      "learn-10-result_and_moodle_id",
      "learn-11-get_vars",
      "learn-12-include",
      "learn-13-alias"
    ]
    filedirname = File.dirname(__FILE__)
    @dirbase = File.join(filedirname, "..", "..", "examples")
  end

  def test_readme_examples
    @examples.each do |name|
      dir = File.join(@dirbase, name)
      cmd = "teuton readme #{dir} > /dev/null"
      assert_equal true, system(cmd)
    end
  end
end
