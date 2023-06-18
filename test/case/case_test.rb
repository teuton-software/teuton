require "test/unit"
require_relative "../../lib/teuton/case/case"

class CaseTest < Test::Unit::TestCase
  def setup
    Project.init
    @testname = "tXX_case_test"
    Project.value[:global] = {tt_testname: @testname}
    @case = Case.new({})
  end

  def test_initialize
    assert_equal 0, @case.action[:id]
    assert_equal 1.0, @case.action[:weight]
    assert_equal "No description!", @case.action[:description]
    assert_nil @case.action[:groupname]
    assert_equal [], @case.uniques
    assert_equal "case-#{@case.id}", @case.filename
  end

  def test_config
    params = {p1: 1, p2: "p2"}
    c = Case.new(params)
    assert_equal params[:p1], c.config.get(:p1)
    assert_equal params[:p2], c.config.get(:p2)
    assert_equal params[:p1], c.config.local[:p1]
    assert_equal params[:p2], c.config.local[:p2]

    assert_equal 0, c.config.running.size
    c.config.set(:p3, "p3")
    assert_equal 1, c.config.running.size
    assert_equal params.size, c.config.local.size
    assert_equal Project.value[:global].size, c.config.global.size

    assert_equal params[:p1], c.get(:p1)
    assert_equal params[:p2], c.get(:p2)
    assert_equal @testname, c.get(:tt_testname)
    assert_equal params[:p1], c._p1
    assert_equal params[:p2], c._p2
    assert_equal @testname, c._tt_testname
  end

  def test_target
    assert_equal "No description!", @case.action[:description]
    assert_equal 1.0, @case.weight

    @case.target "Target 1 description A", weight: 2.5
    assert_equal "Target 1 description A", @case.action[:description]
    assert_equal 2.5, @case.weight

    @case.goal "Target 1 description B"
    assert_equal "Target 1 description B", @case.action[:description]
    assert_equal 1.0, @case.weight

    @case.target "Target 1 description C", asset: "assets/README.md", weight: 3.3
    assert_equal "assets/README.md", @case.action[:asset]
    assert_equal 3.3, @case.weight
  end

  def test_weigth
    assert_equal 1.0, @case.weight
    @case.weight(2.5)
    assert_equal 2.5, @case.weight
    @case.weight(:default)
    assert_equal 1.0, @case.weight
  end

  def test_temfile
    tempdir = File.join("var", @testname, "tmp", @case.id)
    tempfile = File.join(tempdir, "teuton.tmp")
    assert_equal tempdir, @case.tempdir
    assert_equal tempfile, @case.tempfile
    assert_equal "/tmp", @case.remote_tempdir
    assert_equal "/tmp/teuton.tmp", @case.remote_tempfile

    @case.tempfile "othername"
    assert_equal tempdir, @case.tempdir
    assert_equal File.join(tempdir, "othername"), @case.tempfile
    assert_equal "/tmp", @case.remote_tempdir
    assert_equal "/tmp/othername", @case.remote_tempfile

    @case.tempfile :default
    assert_equal tempdir, @case.tempdir
    assert_equal tempfile, @case.tempfile
    assert_equal "/tmp", @case.remote_tempdir
    assert_equal "/tmp/teuton.tmp", @case.remote_tempfile
  end

  def test_skip
    assert_equal false, @case.skip
  end
end
