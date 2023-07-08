require "test/unit"
require_relative "../../lib/teuton/case/case"

class ExpectSequenceTest < Test::Unit::TestCase
  def setup
    Project.init
    Project.value[:global] = {tt_testname: "tXX_expect_sequence"}
    Project.value[:verbose] = false
    @case = Case.new({})
  end

  def test_expect_sequence_find_strings_ok1
    configure_result(@case, %w[a b c d e])
    @case.expect_sequence do
      find "a"
      find "b"
      find "c"
    end
    assert action[:check]
    assert_equal "find(a)>find(b)>find(c)", action[:result]
    assert_equal "", action[:alterations]
    assert_equal "find(a)>find(b)>find(c)", action[:expected]
  end

  def test_expect_sequence_find_strings_ok2
    configure_result(@case, %w[e e e a b c])
    @case.expect_sequence do
      find "a"
      find "b"
      find "c"
    end
    assert action[:check]
    assert_equal "find(a)>find(b)>find(c)", action[:result]
    assert_equal "", action[:alterations]
    assert_equal "find(a)>find(b)>find(c)", action[:expected]
  end

  def test_expect_sequence_find_strings_ok3
    configure_result(@case, %w[e a f b g c d])
    @case.expect_sequence do
      find "a"
      find "b"
      find "c"
    end
    assert action[:check]
    assert_equal "find(a)>find(b)>find(c)", action[:result]
    assert_equal "", action[:alterations]
    assert_equal "find(a)>find(b)>find(c)", action[:expected]
  end

  def test_expect_sequence_find_strings_ok4
    configure_result(@case, %w[a b a b c c])
    @case.expect_sequence do
      find "a"
      find "b"
      find "c"
    end
    assert action[:check]
    assert_equal "find(a)>find(b)>find(c)", action[:result]
    assert_equal "", action[:alterations]
    assert_equal "find(a)>find(b)>find(c)", action[:expected]
  end

  def test_expect_sequence_find_strings_fail5
    configure_result(@case, %w[a b e f a b])
    @case.expect_sequence do
      find "a"
      find "b"
      find "c"
    end
    assert_equal false, action[:check]
    assert_equal "find(a)>find(b)>not find(c)", action[:result]
    assert_equal "", action[:alterations]
    assert_equal "find(a)>find(b)>find(c)", action[:expected]
  end

  def test_expect_sequence_find_strings_fail6
    configure_result(@case, %w[e a e c b])
    @case.expect_sequence do
      find "a"
      find "b"
      find "c"
    end
    assert_equal false, action[:check]
    assert_equal "find(a)>find(b)>not find(c)", action[:result]
    assert_equal "", action[:alterations]
    assert_equal "find(a)>find(b)>find(c)", action[:expected]
  end

  def test_expect_sequence_next_with_strings_ok7
    configure_result(@case, %w[a a b e c])
    @case.expect_sequence do
      find "a"
      next_with "b"
      find "c"
    end
    assert action[:check]
    assert_equal "find(a)>next_with(b)>find(c)", action[:result]
    assert_equal "", action[:alterations]
    assert_equal "find(a)>next_with(b)>find(c)", action[:expected]
  end

  def test_expect_sequence_next_with_strings_ok8
    configure_result(@case, %w[a b a b c c])
    @case.expect_sequence do
      find "a"
      next_with "b"
      next_with "c"
    end
    assert action[:check]
    assert_equal "find(a)>next_with(b)>next_with(c)", action[:result]
    assert_equal "", action[:alterations]
    assert_equal "find(a)>next_with(b)>next_with(c)", action[:expected]
  end

  def test_expect_sequence_next_with_strings_fail9
    configure_result(@case, %w[a a b e c b c])
    @case.expect_sequence do
      find "a"
      next_with "b"
      next_with "c"
    end
    assert_equal false, action[:check]
    assert_equal "find(a)>next_with(b)>not next_with(c)", action[:result]
    assert_equal "", action[:alterations]
    assert_equal "find(a)>next_with(b)>next_with(c)", action[:expected]
  end

  def action = @case.action

  def configure_result(acase, content)
    acase.result.content = content
    acase.result.exitcode = 0
  end
end
