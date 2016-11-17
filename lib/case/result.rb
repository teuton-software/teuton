
class Result
  #attr_accessor :content

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
    prefix = ""
    if @alterations.size > 0
      prefix = @alterations.join(" & ")
    end
    return prefix
  end

  def debug
    my_screen_table = Terminal::Table.new do |st|
      if @content.class==Array then
        st.add_row [ "count=#{@content.count}", "result.debug()" ]
        st.add_separator
        i=0
        @content.each do |item|
          st.add_row [ "Line_"+i.to_s  , item]
          i+=1
        end
      else
        st.add_row [ "", "result.debug()" ]
        st.add_separator
        st.add_row [ @content.class.to_s  , @content.to_s]
      end
    end
    puts "\n"+my_screen_table.to_s+"\n"
  end

  def expected
    return @expected.to_s
  end

  def eq(pValue)
    @expected=pValue

    case pValue.class.to_s
    when 'Fixnum'
      lValue=@content[0].to_i
    when 'Float'
      lValue=@content[0].to_f
    else
      lValue=@content[0]
    end
    return lValue==pValue
  end

  alias_method :eq?, :eq
  alias_method :equal, :eq
  alias_method :equal?, :eq
  alias_method :is_equal?, :eq

  def neq(pValue)
    @expected = "Not equal to #{pValue}"

    case pValue.class.to_s
    when 'Fixnum'
      lValue = @content[0].to_i
    when 'Float'
      lValue = @content[0].to_f
    else
      lValue = @content[0]
    end
    return lValue!=pValue
  end

  alias_method :neq?, :neq
  alias_method :not_equal, :neq
  alias_method :not_equal?, :neq

  # TODO: Error line 102 undefined include? method for 0 Fixnum...
  def find!(pText)
    if @content.size==0
      @alterations << "find!(#{pText.to_s})"
    elsif pText.class==String
      @alterations << "find!(#{pText.to_s})"
      @content.select! { |i| i.include?(pText.to_s) }
    elsif pText.class==Regexp
      @alterations << "find!(#{pText.to_s})"
      temp = @content.clone
      @content= temp.grep pText
    elsif pText.class==Array
      pText.each { |item| find!(item) }
    end

    self
  end

  alias_method :grep!, :find!

  def not_find!(pText)
    @alterations << "grep_v!(#{pText})"
    return self if @content.size==0

    @content.reject! { |i| i.include?(pText) }
    self
  end

  alias_method :grep_v!, :not_find!

  def since!(p_filter)
    if @content.size==0
      @alterations << "since!(#{p_filter.to_s})"
    elsif p_filter.class==String
      @alterations << "since!(#{p_filter.to_s})"
      flag = false
      @content.select! do |i|
        flag = true if i.include?(p_filter.to_s)
        flag
      end
    end
    self
  end

  def until!(p_filter)
    if @content.size==0
      @alterations << "until!(#{p_filter.to_s})"
    elsif p_filter.class==String
      @alterations << "until!(#{p_filter.to_s})"
      flag = true
      @content.select! do |i|
        flag = false if i.include?(p_filter.to_s)
        flag
      end
    end
    self
  end

  def count!
    @alterations << "count!"

    if @content.class == Array
      @content = [ @content.count ]
    elsif @content.nil?
      @content = ["0"]
    else
      @content = [ @content.to_i.to_s ]
    end

    self
  end

  alias_method :length!, :count!
  alias_method :size!, :count!

  def include?(p_value)
    @expected = "Include <#{p_value}> value"
    return @content[0].include? p_value
  end

  def not_include?(p_value)
    @expected = "Not include <#{p_value}> value"
	  return not(@content[0].include? p_value)
  end

  def contain?(pValue)
    @expected="Contain <#{pValue}> value"
    return @content.contain? pValue
  end

  def content=(content)
    @content_backup = content.clone
    @content = content.clone
  end

  def content
    return @content
  end

  #Return 'true' if the parameter value is near to the target value.
  #To get this we consider a 10% desviation or less, as an acceptable result.
  def is_near_to?(p_fvalue)
    @expected="Is near to #{p_fvalue.to_s}"

    return false if @content.nil?
    l_ftarget = @content[0].to_f
    l_fdesv   = (l_ftarget.to_f * 10.0) / 100.0

    return true if ( (l_ftarget-p_fvalue).abs.to_f <= l_fdesv)
    return false
  end

  def empty
    @expected="Empty!"
	return @content.empty
  end

  alias_method :empty?, :empty
  alias_method :is_empty?, :empty

  def ge(p_value)
    @expected="Greater or equal to #{p_value}"
	return false if @content.nil? || @content[0].nil?

    case p_value.class.to_s
    when 'Fixnum'
      l_value = @content[0].to_i
    when 'Float'
      l_value = @content[0].to_f
    else
      l_value = @content[0]
    end
	return l_value >= p_value
  end

  alias_method :greater_or_equal, :ge
  alias_method :greater_or_equal?, :ge

  def gt(pValue)
    @expected="Greater than #{pValue}"
	  return false if @content.nil? || @content[0].nil?

    case pValue.class.to_s
    when 'Fixnum'
      lValue=@content[0].to_i
    when 'Float'
      lValue=@content[0].to_f
    else
      lValue=@content[0]
    end
	  return lValue > pValue
  end

  alias_method :greater, :gt
  alias_method :greater_than, :gt

  def le(p_value)
    @expected = "Lesser or equal to #{p_value.to_s}"

	  return false if @content.nil? || @content[0].nil?
    case p_value.class.to_s
    when 'Fixnum'
      l_value = @content[0].to_i
    when 'Float'
      l_value = @content[0].to_f
    else
      l_value = @content[0]
    end
	  return l_value <= p_value
  end

  alias_method :lesser_or_equal,  :le
  alias_method :lesser_or_equal?, :le

  def lt(p_value)
    @expected = "Lesser than #{p_value.to_s}"

    return false if @content.nil? || @content[0].nil?
    case p_value.class.to_s
    when 'Fixnum'
      l_value = @content[0].to_i
    when 'Float'
      l_value = @content[0].to_f
    else
      l_value = @content[0]
    end
    return l_value < p_value
  end

  alias_method :lesser, :lt
  alias_method :smaller, :lt
  alias_method :lesser_than, :lt
end
