require "minitest/autorun"
require_relative "../lib/case/result"

class TestResult < Minitest::Test
  def setup
    @result = Result.new
    @content = [ "line1","line2","line3" ]
    @result.content=@content
  end

  def test_eq
    filter="line"
    r=@result

    r.content=@content
    assert_equal true, r.grep!(filter).size!.eq(@content.size)
    r.content=@content
    assert_equal true, r.grep!(filter).count!.eq(@content.size)
    r.content=@content
    assert_equal true, r.find!(filter).size!.eq(@content.size)
    r.content=@content
    assert_equal true, r.find!(filter).count!.eq(@content.size)

    r.content=@content
    assert_equal false, r.grep!(filter).size!.eq(0)
    r.content=@content
    assert_equal false, r.grep!(filter).count!.eq(0)
    r.content=@content
    assert_equal false, r.find!(filter).size!.eq(0)
    r.content=@content
    assert_equal false, r.find!(filter).count!.eq(0)
  end

  def test_neq
    filter="line"
    r=@result

    r.content=@content
    assert_equal false, r.grep!(filter).size!.neq(@content.size)
    r.content=@content
    assert_equal false, r.grep!(filter).count!.neq(@content.size)
    r.content=@content
    assert_equal false, r.find!(filter).size!.neq(@content.size)
    r.content=@content
    assert_equal false, r.find!(filter).count!.neq(@content.size)
  end

  def test_grep_string
    filter="line"
    assert_equal @result.grep!(filter).size!.value.to_i, @content.size
    @result.content=@content
    assert_equal @result.grep!(filter).count!.value.to_i, @content.size
    @result.content=@content
    assert_equal @result.find!(filter).size!.value.to_i, @content.size
    @result.content=@content
    assert_equal @result.find!(filter).count!.value.to_i, @content.size
  end
    
  def test_grep_string_filter_1_item
    filter="line1"
    r= @result
    r.grep!(filter)
    assert_equal "find!(line1)" , r.alterations
    assert_equal [ "line1" ] , r.content
    assert_equal 1, @result.content.size
    
    assert_equal 1, r.grep!(filter).size!.value.to_i
    r.content=@content
    assert_equal 1, r.grep!(filter).count!.value.to_i
    r.content=@content
    assert_equal 1, r.find!(filter).size!.value.to_i
    r.content=@content
    assert_equal 1, r.find!(filter).count!.value.to_i
  end

  def test_grep_string_filter_0_item
    filter="line9"
    r= @result
    r.grep!(filter)
    assert_equal "find!(line9)" , r.alterations
    assert_equal [ ] , r.content
    assert_equal 0, @result.content.size
    
    assert_equal 0, r.grep!(filter).size!.value.to_i
    r.content=@content
    assert_equal 0, r.grep!(filter).count!.value.to_i
    r.content=@content
    assert_equal 0, r.find!(filter).size!.value.to_i
    r.content=@content
    assert_equal 0, r.find!(filter).count!.value.to_i
  end

  def test_grep_regexp
    filter=/line[123]/
    assert_equal @result.grep!(filter).size!.value.to_i, @content.size
    @result.content=@content
    assert_equal @result.grep!(filter).count!.value.to_i, @content.size
    @result.content=@content
    assert_equal @result.find!(filter).size!.value.to_i, @content.size
    @result.content=@content
    assert_equal @result.find!(filter).count!.value.to_i, @content.size
  end
  
  def test_grep_regexp_filter_1_item  
    filter=/line1/
    assert_equal 1, @result.grep!(filter).size!.value.to_i
    @result.content=@content
    assert_equal 1, @result.grep!(filter).count!.value.to_i
    @result.content=@content
    assert_equal 1, @result.find!(filter).size!.value.to_i
    @result.content=@content
    assert_equal 1, @result.find!(filter).count!.value.to_i
  end

  def test_grep_regexp_filter_0_item  
    filter=/line9/
    assert_equal 0, @result.grep!(filter).size!.value.to_i
    @result.content=@content
    assert_equal 0, @result.grep!(filter).count!.value.to_i
    @result.content=@content
    assert_equal 0, @result.find!(filter).size!.value.to_i
    @result.content=@content
    assert_equal 0, @result.find!(filter).count!.value.to_i
  end
  
  def test_reset
    assert_equal @result.value, @content[0]
    @result.reset
    assert_equal @result.value, nil    
  end

end
