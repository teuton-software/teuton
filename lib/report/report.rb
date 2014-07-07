#!/usr/bin/ruby
# encoding: utf-8

require_relative 'formatter'

=begin
 This class maintain all the results 
 obtained from every case/test, in a structured way.
=end

class Report
	attr_accessor :outdir, :filename
	attr_accessor :head, :lines, :tail
	attr_accessor :type, :id
		
	def initialize(pId)
		@id=pId
		@outdir="var/out"
		@head={}
		@lines=[]
		@tail={}
	end

	def close_case
		lMax=0.0
		lGood=0.0
		lFail=0.0
		lFailCounter=0
		@lines.each do |i|
			if i.class.to_s=='Hash' then
				lMax += i[:weight]
				if i[:check] then
					lGood+= i[:weight]
				else
					lFail+= i[:weight]
					lFailCounter+=1
				end
			end
		end
		@tail[:max_weight]=lMax
		@tail[:good_weight]=lGood
		@tail[:fail_weight]=lFail
		@tail[:fail_counter]=lFailCounter
		@tail[:grade]=(lGood.to_f/lMax.to_f)*100.0
		if !@tail[:grade].finite? then
			@tail[:grade]=0.0
		end
		@tail[:grade]=0 if @tail[:unique_fault]>0
	end
			
	def show_main
		puts "HEAD"
		@head.each { |key,value| puts "  "+key.to_s+": "+value.to_s }
			
		puts "DATAGROUPS"
		@datagroups.each { |i| i.show }
			
		puts "TAIL"
		@tail.each { |key,value| puts "  "+key.to_s+": "+value.to_s }
	end	
						
	def show(pTab="  ")
		puts 'HEAD'
		@head.each { |key,value| puts pTab+key.to_s+": "+value.to_s }
		puts 'LINES'
		@lines.each do |i|
			if i.class.to_s=='Hash' then
				value=0.0
				value=i[:weight] if i[:check]
				puts pTab+i[:id].to_s+" ("+value.to_s+"/"+i[:weight].to_s+") "+i[:description]
			else
				puts pTab+"- "+i.to_s
			end
		end
		puts 'TAIL'
		@tail.each { |key,value| puts pTab+key.to_s+": "+value.to_s }
	end		

	def export( format)
		filepath= File.join( @outdir, @filename+"."+format.to_s )
		@formatter = FormatterProxy::new(self, format, filepath)
		@formatter.process
	end

end
		

