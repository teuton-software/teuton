require "test/unit"

class ReadmeCommandTest < Test::Unit::TestCase
  def setup
    filedirname = File.dirname(__FILE__)
    @dirbase = File.join(filedirname, "..", "..", "examples")
  end

  def old_test_readme_examples
    puts ""
    @examples.each { |name| execute_readme name }
  end

  def execute_readme(name)
    dir = File.join(@dirbase, name)
    cmd = "./teuton readme #{dir} > /dev/null"
    assert_equal true, system(cmd)
  end

  def self.autocreate_methods_with(names)
    names.each do |name|
      class_eval %{
        def test_readme_#{name.tr("-", "_")}
          execute_readme('#{name}')
        end}, __FILE__, __LINE__ - 3
    end
  end

  autocreate_methods_with %w[
    01-cmd_new 02-target 03-remote_hosts 04-config
    05-use 07-target_weight 08-unique_values 09-send
    10-debug 11-export 12-preserve 13-feedback 14-moodle_id
    15-readme 16-include 17-alias 18-log 19-read_vars
    20-macros 21-exit_codes 22-result 23-test-code 24-test-sql
    25-expect-result 26-expect_sequence 27-run_script
  ]
end
