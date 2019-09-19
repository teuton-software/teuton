# frozen_string_literal: true

# This is an extension of Result class
class Result
  def count
    @alterations << 'count'
    if @content.class == Array
      @content = [@content.count]
      self
    elsif @content.nil?
      @content = ['0']
    else
      @content = [@content.to_i.to_s]
    end
    self
  end

  def include?(value)
    @expected = "Include <#{value}> value"
    @content[0].include?(value)
  end

  def not_include?(value)
    @expected = "Not include <#{value}> value"
    !@content[0].include?(value)
  end

  def contain?(value)
    @expected = "Contain <#{value}> value"
    @content.contain? value
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
