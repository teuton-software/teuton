# encoding: utf-8

class Result
  attr_accessor :content

  def initialize
	reset
  end
		
  def reset
	@content=[]
	@value=nil
	@expected=nil
	@alterations=[]
  end
  
  def value
    @content[0]
  end
  
  def alterations
    prefix=""
    if @alterations.size>0 then
      prefix=@alterations.join(" & ")
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
    @expected="Not equal to #{pValue}"

    case pValue.class.to_s
    when 'Fixnum'
      lValue=@content[0].to_i
    when 'Float'
      lValue=@content[0].to_f
    else
      lValue=@content[0]
    end
    return lValue!=pValue
  end

  alias_method :neq?, :neq
  alias_method :not_equal, :neq
  alias_method :not_equal?, :neq

  def find!(pText)
    @alterations << "find!(#{pText.to_s})"
    return self if @content.size==0

    @content.select! { |i| i.include?(pText.to_s) }
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

  def count!
    @alterations << "count!"

    if @content.class==Array
      @content=[ @content.count ]
    elsif @content.nil?
      @content=["0"]
    else
      @content=["1"]
    end
    
    self
  end

  alias_method :length!, :count!
  alias_method :size!, :count!

  def include?(pValue)
    @expected="Include <#{pValue}> value"
    return @content[0].include? pValue
  end
		
  def not_include?(pValue)
    @expected="Not include <#{pValue}> value"
	return not(@content[0].include? pValue)
  end

  def contain?(pValue)
    @expected="Contain <#{pValue}> value"
    return @content.contain? pValue
  end

  #Return 'true' if the parameter value is near to the target value.
  #To get this we consider a 10% desviation or less, as an acceptable result.
  def is_near_to?(pfValue)
    @expected="Is near to #{pfValue.to_s}"

	return false if @content.nil?
	lfTarget=@content[0].to_f
	lfDesv=(lfTarget.to_f*10.0)/100.0
			 
	return true if ((lfTarget-pfValue).abs.to_f <= lfDesv) 
	return false 
  end
		
  def empty
    @expected="Empty!"
	return @content.empty
  end

  alias_method :empty?, :empty
  alias_method :is_empty?, :empty
	
  def ge(pValue)
    @expected="Greater or equal to #{pValue}"
	return false if @content.nil? || @content[0].nil?

    case pValue.class.to_s
    when 'Fixnum'
      lValue=@content[0].to_i
    when 'Float'
      lValue=@content[0].to_f
    else
      lValue=@content[0]
    end
	return lValue>=pValue
  end

  alias_method :greater_or_equal , :ge
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
	return lValue>pValue
  end

  alias_method :greater, :gt
  alias_method :greater_than, :gt
	
  def le(pValue)
    @expected="Lesser or equal to #{pValue.to_s}"
    
	return false if @content.nil? || @content[0].nil?
    case pValue.class.to_s
    when 'Fixnum'
      lValue=@content[0].to_i
    when 'Float'
      lValue=@content[0].to_f
    else
      lValue=@content[0]
    end
	return lValue<=pValue
  end

  alias_method :lesser_or_equal , :le
  alias_method :lesser_or_equal?, :le

  def lt(pValue)
    @expected="Lesser than #{pValue.to_s}"
    
	return false if @content.nil? || @content[0].nil?
    case pValue.class.to_s
    when 'Fixnum'
      lValue=@content[0].to_i
    when 'Float'
      lValue=@content[0].to_f
    else
      lValue=@content[0]
    end
	return lValue<pValue
  end

  alias_method :lesser, :lt
  alias_method :smaller, :lt
  alias_method :lesser_than, :lt
		
end
