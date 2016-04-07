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
  
  def expected
    prefix=""
    if @alterations.size>0 then
      prefix="[#{@alterations.join("&")}] "
    end
    return prefix+@expected.to_s
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

  alias_method :equal, :eq
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

  alias_method :not_equal, :neq

  def grep!(pText)
    @alterations << "grep!(#{pText})"
    @content.select! { |i| i.include?(pText) }
    self
  end
  alias_method :find!, :grep!

  def grep_v!(pText)
    @alterations << "grep_v!(#{pText})"
    @content.reject! { |i| i.include?(pText) }
    self
  end
  alias_method :not_find!, :grep_v!

  def size!
    @alterations << "size!"
    @content=(@content.size)
    self
  end
  alias_method :count!, :size!

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
		
  def is_empty?
    @expected="Empty!"
	return @content.empty
  end
	
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
