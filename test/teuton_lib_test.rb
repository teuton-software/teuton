require "English"
require "test/unit"

class TeutonLibTest < Test::Unit::TestCase
  def test_run_example_18_log
    output = `ruby -e 'require_relative "./lib/teuton"; Teuton.run("examples/18-log")'`
    exit_status = $CHILD_STATUS.success?

    assert exit_status, "The command failed or returned an error code.\nOutput:\n#{output}"
  end
end
