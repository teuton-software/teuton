require "test/unit"
require_relative "../../lib/teuton/case/case"

class ExpectSequenceTest < Test::Unit::TestCase
  def setup
    Project.init
    Project.value[:global] = {tt_testname: "tXX_expect_sequence"}
    @case = Case.new({})
  end

  def test_expect_sequence_find_strings
    configure_result(@case, %w[a1 b2 c3 d4 e5])
    @case.expect_sequence do
      find "a1"
      find "b2"
      find "c3"
    end
    assert action[:check]
    assert_equal "find(a1) then find(b2) then find(c3)", action[:result]
    assert_equal "", action[:alterations]
    assert_equal "find(a1) then find(b2) then find(c3)", action[:expected]

    configure_result(@case, %w[a1 b2 c3 d4 e5])
    @case.expect_sequence do
      find "a1"
      find "c3"
      find "e5"
    end
    assert action[:check]
    assert_equal "find(a1) then find(c3) then find(e5)", action[:result]
    assert_equal "", action[:alterations]
    assert_equal "find(a1) then find(c3) then find(e5)", action[:expected]
  end

  def test_expect_sequence_find_regexps
    configure_result(@case, %w[a1 b2 c3 d4 e5])
    @case.expect_sequence do
      find(/a/)
      find(/b/)
      find(/c/)
    end
    assert action[:check]

    configure_result(@case, %w[a1 b2 c3 d4 e5])
    @case.expect_sequence do
      find(/a/)
      find(/c/)
      find(/e/)
    end
    assert action[:check]
  end

  def test_expect_sequence_followed_by
    configure_result(@case, %w[a1 b2 c3 d4 e5])
    @case.expect_sequence do
      find "a1"
      followed_by "b2"
      followed_by "c3"
    end
    assert action[:check]
    assert_equal "find(a1) then followed_by(b2) then followed_by(c3)", action[:result]
    assert_equal "", action[:alterations]
    assert_equal "find(a1) then followed_by(b2) then followed_by(c3)", action[:expected]

    configure_result(@case, %w[a1 b2 c3 d4 e5])
    @case.expect_sequence do
      find "a1"
      followed_by "b2"
      find "e5"
    end
    assert action[:check]
    assert_equal "find(a1) then followed_by(b2) then find(e5)", action[:result]
    assert_equal "", action[:alterations]
    assert_equal "find(a1) then followed_by(b2) then find(e5)", action[:expected]
  end

  def action = @case.action

  def configure_result(acase, content)
    acase.result.content = content
    acase.result.exitcode = 0
  end
end
