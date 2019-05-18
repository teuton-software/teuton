

# This is an extension of Result class
class Result
  def count
    @alterations << 'count'

    if @content.class == Array
      @content = [@content.count]
    elsif @content.nil?
      @content = ['0']
    else
      @content = [@content.to_i.to_s]
    end

    self
  end

  def include?(p_value)
    @expected = "Include <#{p_value}> value"
    @content[0].include?(p_value)
  end

  def not_include?(p_value)
    @expected = "Not include <#{p_value}> value"
    !@content[0].include?(p_value)
  end

  def contain?(p_value)
    @expected = "Contain <#{p_value}> value"
    @content.contain? p_value
  end

  def empty
    @expected = 'Empty!'
    @content.empty
  end

  alias count!     count
  alias length     count
  alias len        count
  alias size       count
  alias empty?     empty
end
