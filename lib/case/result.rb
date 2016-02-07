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
		
  def equal?(pValue)
    @expected=pValue
    return @value==pValue
  end

  def not_equal?(pValue)
    @expected=pValue
    return @value!=pValue
  end
	    
  def include?(pValue)
    @expected=pValue
    return @content.include? pValue
  end
		
  def not_include?(pValue)
	return not(@content.include? pValue)
  end

  #Return 'true' if the parameter value is near to the target value.
  #To get this we consider a 10% desviation or less, as an acceptable result.
  def is_near_to?(pfValue)
    @expected=pfValue

	return false if @content.nil?
	lfTarget=@content[0].to_f
	lfDesv=(lfTarget.to_f*10.0)/100.0
			 
	return true if ((lfTarget-pfValue).abs.to_f <= lfDesv) 
	return false 
  end
		
  def is_empty?
	return @content.empty
  end
	
  def is_greater_than?(pValue)
    @expected=pValue
	return false if @content.nil? || @content[0].nil?
	return @content[0]>pValue
  end
	
  def is_less_than?(pValue)
    @expected=pValue
	return false if @content.nil? || @content[0].nil?
	return @content[0]<pValue
  end
		
  def to_f
    @value = @content[0].to_f
	self
  end

  def float
    to_f
  end
  	
  def to_i
    @value = @content[0].to_i
	self
  end
	
  def integer
	to_i
  end

  def to_s
    @value = @content[0].to_s
	self
  end
	
  def string
	to_s
  end
  
  def data
    value
  end
end
