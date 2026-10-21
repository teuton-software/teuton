require "test/unit"
require_relative "../../lib/teuton/case/case"

class ExpectSequenceCaseTest < Test::Unit::TestCase
  def setup
    Project.init
    Project.value[:global] = { tt_testname: "tXX_expect_sequence" }
    Project.value[:verbose] = false
  end

  def test_expect_sequence_find_strings_ok01
    acase = Case.new({})

    configure_result(acase, %w[a b c d e])
    acase.expect_sequence do
      find "a"
      find "b"
      find "c"
    end
    action = acase.last_action

    assert action.check
    assert_equal "find(a)>find(b)>find(c)", action.result
    assert_equal "", action.alterations
    assert_equal "find(a)>find(b)>find(c)", action.expected
  end

  def test_expect_sequence_find_strings_ok02
    acase = Case.new({})

    configure_result(acase, %w[e e e a b c])
    acase.expect_sequence do
      find "a"
      find "b"
      find "c"
    end
    action = acase.last_action

    assert action.check
    assert_equal "find(a)>find(b)>find(c)", action.result
    assert_equal "", action.alterations
    assert_equal "find(a)>find(b)>find(c)", action.expected
  end

  def test_expect_sequence_find_strings_ok03
    acase = Case.new({})

    configure_result(acase, %w[e a f b g c d])
    acase.expect_sequence do
      find "a"
      find "b"
      find "c"
    end
    action = acase.last_action

    assert action.check
    assert_equal "find(a)>find(b)>find(c)", action.result
    assert_equal "", action.alterations
    assert_equal "find(a)>find(b)>find(c)", action.expected
  end

  def test_expect_sequence_find_strings_ok04
    acase = Case.new({})

    configure_result(acase, %w[a b a b c c])
    acase.expect_sequence do
      find "a"
      find "b"
      find "c"
    end
    action = acase.last_action

    assert action.check
    assert_equal "find(a)>find(b)>find(c)", action.result
    assert_equal "", action.alterations
    assert_equal "find(a)>find(b)>find(c)", action.expected
  end

  def test_expect_sequence_find_strings_fail05
    acase = Case.new({})

    configure_result(acase, %w[a b e f a b])
    acase.expect_sequence do
      find "a"
      find "b"
      find "c"
    end
    action = acase.last_action

    assert_equal false, action.check
    assert_equal "find(a)>find(b)>not find(c)", action.result
    assert_equal "", action.alterations
    assert_equal "find(a)>find(b)>find(c)", action.expected
  end

  def test_expect_sequence_find_strings_fail06
    acase = Case.new({})

    configure_result(acase, %w[e a e c b])
    acase.expect_sequence do
      find "a"
      find "b"
      find "c"
    end
    action = acase.last_action

    assert_equal false, action.check
    assert_equal "find(a)>find(b)>not find(c)", action.result
    assert_equal "", action.alterations
    assert_equal "find(a)>find(b)>find(c)", action.expected
  end

  def test_expect_sequence_next_with_strings_ok07
    acase = Case.new({})

    configure_result(acase, %w[a a b e c])
    acase.expect_sequence do
      find "a"
      next_to "b"
      find "c"
    end
    action = acase.last_action

    assert action.check
    assert_equal "find(a)>next_to(b)>find(c)", action.result
    assert_equal "", action.alterations
    assert_equal "find(a)>next_to(b)>find(c)", action.expected
  end

  def test_expect_sequence_next_with_strings_ok08
    acase = Case.new({})

    configure_result(acase, %w[a b a b c c])
    acase.expect_sequence do
      find "a"
      next_to "b"
      next_to "c"
    end
    action = acase.last_action

    assert action.check
    assert_equal "find(a)>next_to(b)>next_to(c)", action.result
    assert_equal "", action.alterations
    assert_equal "find(a)>next_to(b)>next_to(c)", action.expected
  end

  def test_expect_sequence_next_with_strings_fail09
    acase = Case.new({})

    configure_result(acase, %w[a a b e c b c])
    acase.expect_sequence do
      find "a"
      next_to "b"
      next_to "c"
    end
    action = acase.last_action

    assert_equal false, action.check
    assert_equal "find(a)>next_to(b)>not next_to(c)", action.result
    assert_equal "", action.alterations
    assert_equal "find(a)>next_to(b)>next_to(c)", action.expected
  end

  def test_expect_sequence_move_strings_ok10
    acase = Case.new({})

    configure_result(acase, %w[a e b e c e e])
    acase.expect_sequence do
      find "a"
      ignore 1
      next_to "b"
      ignore 1
      next_to "c"
    end
    action = acase.last_action

    assert action.check
    assert_equal "find(a)>ignore(1)>next_to(b)>ignore(1)>next_to(c)", action.result
    assert_equal "", action.alterations
    assert_equal "find(a)>ignore(1)>next_to(b)>ignore(1)>next_to(c)", action.expected
  end

  def test_expect_sequence_move_strings_ok11
    acase = Case.new({})

    configure_result(acase, %w[e e a b e b e])
    acase.expect_sequence do
      find "a"
      ignore 2
      next_to "b"
    end
    action = acase.last_action

    assert action.check
    assert_equal "find(a)>ignore(2)>next_to(b)", action.result
    assert_equal "", action.alterations
    assert_equal "find(a)>ignore(2)>next_to(b)", action.expected
  end

  def test_expect_sequence_move_strings_fail12
    acase = Case.new({})

    configure_result(acase, %w[e e a b b e b])
    acase.expect_sequence do
      find "a"
      ignore 2
      next_to "b"
    end
    action = acase.last_action

    assert_equal false, action.check
    assert_equal "find(a)>ignore(2)>not next_to(b)", action.result
    assert_equal "", action.alterations
    assert_equal "find(a)>ignore(2)>next_to(b)", action.expected
  end

  def configure_result(acase, content)
    acase.result.content = content
    acase.result.exitcode = 0
  end
end
