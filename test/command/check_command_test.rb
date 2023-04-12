require "test/unit"

class CheckCommandTest < Test::Unit::TestCase
  def setup
    filedirname = File.dirname(__FILE__)
    @dirbase = File.join(filedirname, "..", "..", "examples")
  end

  def old_test_check_examples
    puts ""
    @examples.each { |name| execute_check name }
  end

  def execute_check(name)
    dir = File.join(@dirbase, name)
    cmd = "teuton check #{dir} 2>/dev/null 1>/dev/null"
    assert_equal true, system(cmd)
  end

  def self.autocreate_methods_with(names)
    names.each do |name|
      class_eval %{
        def test_check_#{name.tr("-", "_")}
          execute_check('#{name}')
        end}, __FILE__, __LINE__ - 3
    end
  end

  autocreate_methods_with %w[
    01-cmd_new 02-target 03-remote_hosts 04-config
    05-use 07-target_weight 08-unique_values 09-send
    10-debug 11-export 12-preserve 13-feedback 14-moodle_id
    15-readme 16-include 17-alias 18-log 19-read_vars
    21-exit_codes 22-result 23-test-code 24-test-sql
  ]
end
