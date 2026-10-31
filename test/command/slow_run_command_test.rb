require "test/unit"

class RunCommandTest < Test::Unit::TestCase
  def setup
    filedirname = File.dirname(__FILE__)
    @dirbase = File.join(filedirname, "..", "..", "examples")
  end

  def old(test_run_examples)
    puts ""
    @examples.each { |name| execute_run name }
  end

  def execute_run(name)
    dir = File.join(@dirbase, name)

    cmd = "./teuton run --quiet #{dir} > /dev/null"
    assert_equal true, system(cmd)

    cmd = "./teuton #{dir} > /dev/null"
    assert_equal true, system(cmd)
  end

  def self.autocreate_methods_with(names)
    names.each do |name|
      class_eval %{
        def test_run_#{name.tr('-', '_')}
          execute_run('#{name}')
        end}, __FILE__, __LINE__ - 3
    end
  end

  autocreate_methods_with %w[
    101-cmd_new 102-target 103-remote_hosts 104-config 105-target_weight 106-send
    201-use 203-debug 204-unique-values 205-include 206-zero-weight-target 207-negative-weight-target
    301-log 302-export 303-doc 304-preserve 305-feedback 306-moodle_id
    401-exit-code 402-result 403-expect-result 404-expect_sequence 405-run_script 406-upload
    501-stop-test 502-scores-to-zero 503-zero-and-stop 504-all-targets
    601-test-code 602-test-sql
    701-read-vars 702-alias 703-macros
  ]
end
