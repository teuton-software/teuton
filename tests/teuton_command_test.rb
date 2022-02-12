#!/usr/bin/ruby

require 'minitest/autorun'

class TeutonCommandTest < Minitest::Test

  def setup
    @examples = [ 'learn-01-target', 'learn-02-config' ]
    @dirbase = 'example'
  end

  def test_version
    assert_equal true,  system('teuton version > /dev/null')
  end

  def notest_new
    dir = 'delete.this.new'
    cmd = "teuton new #{dir} > /dev/null"
    assert_equal true,  system(cmd)

    files = [ 'start.rb', 'config.yaml']

    files.each do |filename|
      filepath = File.join(dir, filename)
      assert_equal true, File.exist?(filepath)
    end

    files.each do |filename|
      filepath = File.join(dir, filename)
      assert_equal true,  system("rm #{filename}")
    end

    assert_equal true,  system("rmdir #{dir}")
  end

  def notest_check_examples
    @examples.each do |name|
      dir = File.join(@dirbase, name)
      cmd = "teuton check #{dir} > /dev/null"
      assert_equal true,  system(cmd)
    end
  end

  def notest_run_examples
    @examples.each do |name|
      dir = File.join(@dirbase, name)

      #require 'pry-byebug'; binding.pry
      cmd = "teuton run #{dir} > /dev/null"
      #assert_equal true,  system(cmd)

      cmd = "teuton #{dir} > /dev/null"
      assert_equal true,  system(cmd)
    end
  end

  def notest_readme_examples
    @examples.each do |name|
      dir = File.join(@dirbase, name)

      cmd = "teuton readme #{dir} > /dev/null"
      assert_equal true,  system(cmd)
    end
  end
end
