#!/usr/bin/ruby
# encoding: utf-8

require_relative 'formatter'

=begin
This class maintain all the results obtained from every case/test, 
in a structured way.
=end

class Report
	attr_accessor :head, :outdir, :datagroups
	attr_reader :tail
		
	def initialize
		@head={}
		@datagroups=[]
		@tail={}
		@outdir="var/out"
	end
	
	def new_datagroup
		d = DataGroup.new
		@datagroups << d
		d.order = @datagroups.index(d)
		return d
	end
	
	def close
		lOrder=0
		@datagroups.each do |g|
			lOrder=lOrder+1
			lMembers=g.head[:tt_members] || 'noname'
			lGrade=g.tail[:grade] || 0.0
			lHelp=" "
			lHelp="?" if lGrade<50.0
			lHelp="*" if lGrade==100.0
			
			@tail[("result_"+lOrder.to_s).to_sym]="#{lHelp} (#{lGrade.to_s}) #{lMembers}"
		end
	end
		
	def show
		puts "HEAD"
		@head.each { |key,value| puts "  "+key.to_s+": "+value.to_s }
			
		puts "DATAGROUPS"
		@datagroups.each { |i| i.show }
			
		puts "TAIL"
		@tail.each { |key,value| puts "  "+key.to_s+": "+value.to_s }
	end
	
	def export( pType, pArgs={})
		pArgs[:dirname]=@outdir if !pArgs[:dirname]
		@formatter = FormatterProxy::new(self, pType, pArgs)
		@formatter.process
	end

	class DataGroup
		attr_accessor :head, :lines, :tail
		attr_accessor :type, :order
		def initialize
			@head={}
			@lines=[]
			@tail={}
			@type=:default
		end
		
		def close
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
						
		def show(pTab="  ")
			puts pTab+'HEAD'
			@head.each { |key,value| puts pTab*2+key.to_s+": "+value.to_s }
			puts pTab+'LINES'
			@lines.each do |i|
				if i.class.to_s=='Hash' then
					value=0.0
					value=i[:weight] if i[:check]
					puts pTab*2+i[:id].to_s+" ("+value.to_s+"/"+i[:weight].to_s+") "+i[:description]
				else
					puts pTab*2+"- "+i.to_s
				end
			end
			puts pTab+'TAIL'
			@tail.each { |key,value| puts pTab*2+key.to_s+": "+value.to_s }
		end		
	end

end
		

