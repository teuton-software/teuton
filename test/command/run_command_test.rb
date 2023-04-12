require "test/unit"

class RunCommandTest < Test::Unit::TestCase
  def setup
    filedirname = File.dirname(__FILE__)
    @dirbase = File.join(filedirname, "..", "..", "examples")
  end

  def old test_run_examples
    puts ""
    @examples.each { |name| execute_run name }
  end

  def execute_run(name)
    dir = File.join(@dirbase, name)

    cmd = "teuton run --quiet #{dir} > /dev/null"
    assert_equal true, system(cmd)

    cmd = "teuton #{dir} > /dev/null"
    assert_equal true, system(cmd)
  end

  def self.autocreate_methods_with(names)
    names.each do |name|
      class_eval %{
        def test_run_#{name.tr("-", "_")}
          execute_run('#{name}')
        end}, __FILE__, __LINE__ - 3
    end
  end

  autocreate_methods_with %w[
    01-cmd_new 02-target
    11-export 13-feedback 14-moodle_id
    15-readme 16-include 17-alias 18-log 19-read_vars
    21-exit_codes 22-result 23-test-code 24-test-sql
  ]
end
