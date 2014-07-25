#!/usr/bin/ruby
# encoding: utf-8

class Result
	attr_accessor :content
		
	def initialize
		reset
	end
		
	def reset
		@content=[]
	end
		
	def equal?(pValue)
		return @content[0]==pValue
	end
		
	def not_equal?(pValue)
		return !equal?(pValue)
	end

	def include?(pValue)
		return @content.include? pValue
	end
		
	def not_include?(pValue)
		return not(@content.include? pValue)
	end

	#Return 'true' if the parameter value is near to the target value.
	#To get this we consider a 10% desviation or less, as an acceptable result.
	def is_near_to?(pfValue)
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
		return false if @content.nil? || @content[0].nil?
		return @content[0]>pValue
	end
	
	def is_less_than?(pValue)
		return false if @content.nil? || @content[0].nil?
		return @content[0]<pValue
	end
		
	def to_f
		r = Result.new
		@content.each { |i| r.content<<i.to_f }
		return r
	end
		
	def to_i
		r = Result.new
		@content.each { |i| r.content<<i.to_i }
		return r
	end

	def to_s
		r = Result.new
		@content.each { |i| r.content<<i.to_s }
		return r
	end
	
	def value
		@content[0]
	end
end
