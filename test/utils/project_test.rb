require "test/unit"
require_relative "../../lib/teuton/utils/project"

class ProjectTest < Test::Unit::TestCase
  def setup
    Project.init
  end

  def test_init_params
    assert_equal false, Project.debug?
    assert_equal true, Project.verbose

    v = Project.value
    assert_equal "var", v[:output_basedir]
    assert_equal true, v[:global] == {}
    assert_equal [], v[:groups]
    assert_equal [], v[:hall_of_fame]
  end

  def test_quiet?
    v = Project.value
    v[:verbose] = false
    assert_equal false, Project.verbose
    assert_equal true, Project.quiet?
    v[:verbose] = true
    assert_equal true, Project.verbose
    assert_equal false, Project.quiet?
    v[:options]["quiet"] = true
    assert_equal true, Project.quiet?
  end
end
