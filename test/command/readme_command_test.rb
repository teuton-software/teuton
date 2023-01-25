#!/usr/bin/ruby

require "test/unit"

class ReadmeCommandTest < Test::Unit::TestCase
  def setup
    @examples = [
      "02-target",
      "03-remote_hosts",
      "04-config",
      "05-new_test",
      "06-use",
      "07-debug",
      "07-log",
      "08-readme",
      "09-preserve",
      "10-result",
      "11-moodle_id",
      "12-get_vars",
      "13-include",
      "14-alias"
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
