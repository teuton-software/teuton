require "test/unit"
require_relative "../../lib/teuton/case/dsl/expect_sequence"

class ExpectSequenceClassTest < Test::Unit::TestCase
  def test_expect_sequence_find_strings_ok01
    es = ExpectSequence.new(%w[a b c d e])
    es.is_valid? do
      find "a"
      find "b"
      find "c"
    end
    assert es.result[:ok]
    assert_equal "find(a)>find(b)>find(c)", es.real
    assert_equal "find(a)>find(b)>find(c)", es.expected
    assert_equal 3, es.result[:score]
    assert_equal 1, es.states.size
  end

  def test_expect_sequence_find_strings_ok02
    es = ExpectSequence.new(%w[e e e a b c])
    es.is_valid? do
      find "a"
      find "b"
      find "c"
    end
    assert es.result[:ok]
    assert_equal "find(a)>find(b)>find(c)", es.real
    assert_equal "find(a)>find(b)>find(c)", es.expected
    assert_equal 3, es.result[:score]
    assert_equal 1, es.states.size
  end

  def test_expect_sequence_find_strings_ok03
    es = ExpectSequence.new(%w[e a f b g c d])
    es.is_valid? do
      find "a"
      find "b"
      find "c"
    end
    assert es.result[:ok]
    assert_equal "find(a)>find(b)>find(c)", es.real
    assert_equal "find(a)>find(b)>find(c)", es.expected
    assert_equal 3, es.result[:score]
    assert_equal 1, es.states.size
  end

  def test_expect_sequence_find_strings_ok04
    es = ExpectSequence.new(%w[a b a b c c])
    es.is_valid? do
      find "a"
      find "b"
      find "c"
    end
    assert es.result[:ok]
    assert_equal "find(a)>find(b)>find(c)", es.real
    assert_equal "find(a)>find(b)>find(c)", es.expected
    assert_equal 3, es.result[:score]
    assert_equal 6, es.states.size
  end

  def test_expect_sequence_find_strings_fail05
    es = ExpectSequence.new(%w[a b e f a b])
    es.is_valid? do
      find "a"
      find "b"
      find "c"
    end
    assert_equal false, es.result[:ok]
    assert_equal "find(a)>find(b)>not find(c)", es.real
    assert_equal "find(a)>find(b)>find(c)", es.expected
    assert_equal 2, es.result[:score]
    assert_equal 3, es.states.size
  end

  def test_expect_sequence_find_strings_fail06
    es = ExpectSequence.new(%w[e a e c b])
    es.is_valid? do
      find "a"
      find "b"
      find "c"
    end
    assert_equal false, es.result[:ok]
    assert_equal "find(a)>find(b)>not find(c)", es.real
    assert_equal "find(a)>find(b)>find(c)", es.expected
    assert_equal 2, es.result[:score]
    assert_equal 1, es.states.size
  end

  def test_expect_sequence_next_with_strings_ok07
    es = ExpectSequence.new(%w[a a b e c])
    es.is_valid? do
      find "a"
      next_with "b"
      find "c"
    end
    assert es.result[:ok]
    assert_equal "find(a)>next_with(b)>find(c)", es.real
    assert_equal "find(a)>next_with(b)>find(c)", es.expected
    assert_equal 3, es.result[:score]
    assert_equal 2, es.states.size
  end

  def test_expect_sequence_next_with_strings_ok08
    es = ExpectSequence.new(%w[a b a b c c])
    es.is_valid? do
      find "a"
      next_with "b"
      next_with "c"
    end
    assert es.result[:ok]
    assert_equal "find(a)>next_with(b)>next_with(c)", es.real
    assert_equal "find(a)>next_with(b)>next_with(c)", es.expected
    assert_equal 3, es.result[:score]
    assert_equal 2, es.states.size
  end

  def test_expect_sequence_next_with_strings_fail09
    es = ExpectSequence.new(%w[a a b e c b c])
    es.is_valid? do
      find "a"
      next_with "b"
      next_with "c"
    end
    assert_equal false, es.result[:ok]
    assert_equal "find(a)>next_with(b)>not next_with(c)", es.real
    assert_equal "find(a)>next_with(b)>next_with(c)", es.expected
    assert_equal 2, es.result[:score]
    assert_equal 2, es.states.size
  end

  def test_expect_sequence_move_strings_ok10
    es = ExpectSequence.new(%w[a e b e c e e])
    es.is_valid? do
      find "a"
      move 1
      next_with "b"
      move 1
      next_with "c"
    end
    assert es.result[:ok]
    assert_equal "find(a)>move(1)>next_with(b)>move(1)>next_with(c)", es.real
    assert_equal "find(a)>move(1)>next_with(b)>move(1)>next_with(c)", es.expected
    assert_equal 5, es.result[:score]
    assert_equal 1, es.states.size
  end

  def test_expect_sequence_move_strings_ok11
    es = ExpectSequence.new(%w[e e a b e b e])
    es.is_valid? do
      find "a"
      move 2
      next_with "b"
    end
    assert es.result[:ok]
    assert_equal "find(a)>move(2)>next_with(b)", es.real
    assert_equal "find(a)>move(2)>next_with(b)", es.expected
  end

  def test_expect_sequence_move_strings_fail12
    es = ExpectSequence.new(%w[e e a b b e b])
    es.is_valid? do
      find "a"
      move 2
      next_with "b"
    end
    assert_equal false, es.result[:ok]
    assert_equal "find(a)>move(2)>not next_with(b)", es.real
    assert_equal "find(a)>move(2)>next_with(b)", es.expected
  end
end
