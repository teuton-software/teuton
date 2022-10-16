#!/usr/bin/ruby

require "test/unit"

class TeutonCommandTest < Test::Unit::TestCase
  def setup
    @examples = [
      "learn-01-target",
      "learn-02-config"
    ]
    filedirname = File.dirname(__FILE__)
    @dirbase = File.join(filedirname, "..", "examples")
  end

  def test_version
    assert_equal true, system("teuton version > /dev/null")
  end

  def test_new
    dir = "delete.this.new"
    cmd = "teuton new #{dir} > /dev/null"
    assert_equal true, system(cmd)

    files = ["start.rb", "config.yaml"]

    files.each do |filename|
      filepath = File.join(dir, filename)
      assert_equal true, File.exist?(filepath)
    end

    files.each do |filename|
      filepath = File.join(dir, filename)
      assert_equal true, system("rm #{filepath}")
    end

    assert_equal true, system("rmdir #{dir}")
  end

  def test_check_examples
    @examples.each do |name|
      dir = File.join(@dirbase, name)
      cmd = "teuton check #{dir} > /dev/null"
      assert_equal true, system(cmd)
    end
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

  def test_readme_examples
    examples = [
      "learn-01-target",
      "learn-02-config",
      "learn-03-remote-hosts",
      "learn-04-new-test",
      "learn-05-use",
      "learn-06-debug",
      "learn-07-log",
      "learn-08-readme",
      "learn-09-preserve",
      "learn-10-result-and-moodle_id",
      "learn-11-get_vars",
      "learn-12-include",
      "learn-13-alias"
    ]

    examples.each do |name|
      dir = File.join(@dirbase, name)

      cmd = "teuton readme #{dir} > /dev/null"
      assert_equal true, system(cmd)
    end
  end
end
