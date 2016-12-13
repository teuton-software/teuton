
require_relative 'result/ext_filter'
require_relative 'result/ext_compare'

# This object contains data returned by remote execution
class Result
  attr_reader :content

  def initialize
    reset
  end

  def reset
    @content_backup = []
    @content        = []
    @value          = nil
    @expected       = nil
    @alterations    = []
  end

  def restore!
    temp = @content_backup.clone
    reset
    @content_backup = temp
    @content        = temp.clone
  end

  def value
    @content[0]
  end

  def alterations
    return '' if @alterations.size.zero?
    @alterations.join(' & ')
  end

  def expected
    @expected.to_s
  end

  def content=(content)
    @content_backup = content.clone
    @content = content.clone
  end

  def debug
    my_screen_table = Terminal::Table.new do |st|
      if @content.class == Array
        st.add_row ["count=#{@content.count}", 'result.debug()']
        st.add_separator
        i = 0
        @content.each do |item|
          st.add_row ['Line_' + i.to_s, item]
          i += 1
        end
      else
        st.add_row ['', 'result.debug()']
        st.add_separator
        st.add_row [@content.class.to_s, @content.to_s]
      end
    end
    puts '\n' + my_screen_table.to_s + '\n'
  end

  def count!
    @alterations << 'count!'

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

  # Return 'true' if the parameter value is near to the target value.
  # To get this we consider a 10% desviation or less, as an acceptable result.
  def near_to?(p_fvalue)
    @expected = "Is near to #{p_fvalue}"

    return false if @content.nil?
    l_ftarget = @content[0].to_f
    l_fdesv   = (l_ftarget.to_f * 10.0) / 100.0

    return true if (l_ftarget - p_fvalue).abs.to_f <= l_fdesv
    false
  end

  def empty
    @expected = 'Empty!'
    @content.empty
  end

  alias length!    count!
  alias size!      count!
  alias empty?     empty
end

=begin
alias grep!      find!
alias grep_v!    not_find!

# TODO: Error line 102 undefined include? method for 0 Fixnum...
def find!(p_filter)
  case p_filter.class.to_s
  when 'Array'
    p_filter.each { |item| find!(item) }
    return self
  when 'String'
    @alterations << "find!(#{p_filter})"
    @content.select! { |i| i.include?(p_filter.to_s) }
  when 'Regexp'
    @alterations << "find!(#{p_filter})"
    temp = @content.clone
    @content = temp.grep p_filter
  end
  self
end

def not_find!(p_filter)
  @alterations << "grep_v!(#{p_filter})"
  return self if @content.size.zero?

  @content.reject! { |i| i.include?(p_filter) }
  self
end

def since!(p_filter)
  @alterations << "since!(#{p_filter})"
  return self if @content.size.zero?
  if p_filter.class == String
    flag = false
    @content.select! do |i|
      flag = true if i.include?(p_filter.to_s)
      flag
    end
  end
  self
end

def until!(p_filter)
  @alterations << "until!(#{p_filter})"
  return self if @content.size.zero?
  if p_filter.class == String
    flag = true
    @content.select! do |i|
      flag = false if i.include?(p_filter.to_s)
      flag
    end
  end
  self
end

def eq(p_value)
  @expected = p_value

  case p_value.class.to_s
  when 'Fixnum'
    l_value = @content[0].to_i
  when 'Float'
    l_value = @content[0].to_f
  else
    l_value = @content[0]
  end
  l_value == p_value
end

def neq(p_value)
  @expected = "Not equal to #{p_value}"

  case p_value.class.to_s
  when 'Fixnum'
    l_value = @content[0].to_i
  when 'Float'
    l_value = @content[0].to_f
  else
    l_value = @content[0]
  end
  l_value != p_value
end

def ge(p_value)
  @expected = "Greater or equal to #{p_value}"
  return false if @content.nil? || @content[0].nil?

  l_value = @content[0]
  case p_value.class.to_s
  when 'Fixnum'
    l_value = @content[0].to_i
  when 'Float'
    l_value = @content[0].to_f
  end
  l_value >= p_value
end

def gt(p_value)
  @expected = "Greater than #{p_value}"
  return false if @content.nil? || @content[0].nil?

  l_value = @content[0]
  case p_value.class.to_s
  when 'Fixnum'
    l_value = @content[0].to_i
  when 'Float'
    l_value = @content[0].to_f
  end
  l_value > p_value
end

def le(p_value)
  @expected = "Lesser or equal to #{p_value}"

  return false if @content.nil? || @content[0].nil?
  l_value = @content[0]
  case p_value.class.to_s
  when 'Fixnum'
    l_value = @content[0].to_i
  when 'Float'
    l_value = @content[0].to_f
  end
  l_value <= p_value
end

def lt(p_value)
  @expected = "Lesser than #{p_value}"
  return false if @content.nil? || @content[0].nil?

  l_value = @content[0]
  case p_value.class.to_s
  when 'Fixnum'
    l_value = @content[0].to_i
  when 'Float'
    l_value = @content[0].to_f
  end
  l_value < p_value
end

alias eq?        eq
alias equal      eq
alias equal?     eq
alias is_equal?  eq
alias neq?       neq
alias not_equal  neq
alias not_equal? neq
alias greater_or_equal  ge
alias greater_or_equal? ge
alias greater          gt
alias greater_than     gt
alias lesser_or_equal  le
alias lesser_or_equal? le
alias lesser  lt
alias smaller lt
alias lesser_than lt

=end
