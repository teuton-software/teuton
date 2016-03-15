# encoding: utf-8

class Result
  attr_accessor :content
  attr_reader :expected, :value

  def initialize
	reset
  end
		
  def reset
	@content=[]
	@value=nil
	@expected=nil
  end
  
  def value
    @content[0]
  end
  
  def equal(pValue)
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

  alias_method :is_equal?, :equal
  
  def not_equal(pValue)
    return !equal?(pValue)
  end
	    
  def include?(pValue)
    @expected="Include <#{pValue}> value"
    return @content.include? pValue
  end
		
  def not_include?(pValue)
    @expected="Not include <#{pValue}> value"
	return not(@content.include? pValue)
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
	
  def greater(pValue)
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
	
  def smaller(pValue)
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
  
  def contain?(pValue)
    @expected="Contain <#{pValue}> value"
    return @content.contain? pValue
  end
		
end
