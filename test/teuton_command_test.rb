#!/usr/bin/ruby

require "test/unit"

class TeutonCommandTest < Test::Unit::TestCase
  def setup
    @examples = [
      "learn-01-target",
      "learn-02-config",
      "learn-03-remote-hosts",
      # "learn-15-exit-codes"
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
    @examples.each do |name|
      dir = File.join(@dirbase, name)

      cmd = "teuton readme #{dir} > /dev/null"
      assert_equal true, system(cmd)
    end
  end
end
