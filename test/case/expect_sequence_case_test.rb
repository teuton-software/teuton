require "test/unit"
require_relative "../../lib/teuton/case/case"

class ExpectSequenceCaseTest < Test::Unit::TestCase
  def setup
    Project.init
    Project.value[:global] = {tt_testname: "tXX_expect_sequence"}
    Project.value[:verbose] = false
    @case = Case.new({})
  end

  def test_expect_sequence_find_strings_ok01
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

  def test_expect_sequence_find_strings_ok02
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

  def test_expect_sequence_find_strings_ok03
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

  def test_expect_sequence_find_strings_ok04
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

  def test_expect_sequence_find_strings_fail05
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

  def test_expect_sequence_find_strings_fail06
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

  def test_expect_sequence_next_with_strings_ok07
    configure_result(@case, %w[a a b e c])
    @case.expect_sequence do
      find "a"
      next_to "b"
      find "c"
    end
    assert action[:check]
    assert_equal "find(a)>next_to(b)>find(c)", action[:result]
    assert_equal "", action[:alterations]
    assert_equal "find(a)>next_to(b)>find(c)", action[:expected]
  end

  def test_expect_sequence_next_with_strings_ok08
    configure_result(@case, %w[a b a b c c])
    @case.expect_sequence do
      find "a"
      next_to "b"
      next_to "c"
    end
    assert action[:check]
    assert_equal "find(a)>next_to(b)>next_to(c)", action[:result]
    assert_equal "", action[:alterations]
    assert_equal "find(a)>next_to(b)>next_to(c)", action[:expected]
  end

  def test_expect_sequence_next_with_strings_fail09
    configure_result(@case, %w[a a b e c b c])
    @case.expect_sequence do
      find "a"
      next_to "b"
      next_to "c"
    end
    assert_equal false, action[:check]
    assert_equal "find(a)>next_to(b)>not next_to(c)", action[:result]
    assert_equal "", action[:alterations]
    assert_equal "find(a)>next_to(b)>next_to(c)", action[:expected]
  end

  def test_expect_sequence_move_strings_ok10
    configure_result(@case, %w[a e b e c e e])
    @case.expect_sequence do
      find "a"
      ignore 1
      next_to "b"
      ignore 1
      next_to "c"
    end
    assert action[:check]
    assert_equal "find(a)>ignore(1)>next_to(b)>ignore(1)>next_to(c)", action[:result]
    assert_equal "", action[:alterations]
    assert_equal "find(a)>ignore(1)>next_to(b)>ignore(1)>next_to(c)", action[:expected]
  end

  def test_expect_sequence_move_strings_ok11
    configure_result(@case, %w[e e a b e b e])
    @case.expect_sequence do
      find "a"
      ignore 2
      next_to "b"
    end
    assert action[:check]
    assert_equal "find(a)>ignore(2)>next_to(b)", action[:result]
    assert_equal "", action[:alterations]
    assert_equal "find(a)>ignore(2)>next_to(b)", action[:expected]
  end

  def test_expect_sequence_move_strings_fail12
    configure_result(@case, %w[e e a b b e b])
    @case.expect_sequence do
      find "a"
      ignore 2
      next_to "b"
    end
    assert_equal false, action[:check]
    assert_equal "find(a)>ignore(2)>not next_to(b)", action[:result]
    assert_equal "", action[:alterations]
    assert_equal "find(a)>ignore(2)>next_to(b)", action[:expected]
  end

  def action = @case.action

  def configure_result(acase, content)
    acase.result.content = content
    acase.result.exitcode = 0
  end
end
