#!/usr/bin/ruby
require "minitest/autorun"

class TestDemo < Minitest::Test
  def setup
    @name = "obiwan"
  end

  def test_ok
    assert_equal "OBIWAN", @name.upcase
    assert_equal 6, @name.size
  end

  def test_fail
    assert_equal "obi-wan", @name
  end

end
