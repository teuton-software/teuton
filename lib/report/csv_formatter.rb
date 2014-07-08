#!/usr/bin/ruby
# encoding: utf-8

require_relative 'base_formatter'

class CSVFormatter < BaseFormatter
	
	def initialize(pReport)
		super(pReport)
	end
		
	def process
		d=";"
		@head.each { |key,value| w "HEAD"+d+key.to_s+d+value.to_s+"\n" }
		@datagroups.each { |item| process_datagroup item }
		@tail.each { |key,value| w "TAIL"+d+key.to_s+d+value.to_s+"\n" }
		
		deinit
	end
	
	def process_datagroup(pGroup)
		d=@params[:delimiter]
		a = "DATAGROUP"+pGroup.order.to_s+d
		pGroup.head.each { |key,value| w a+"HEAD"+d+key.to_s+d+value.to_s+"\n" }
		pGroup.lines.each do |i|
			if i.class.to_s=='Hash' then
				w a+"LINES"+d+"ACTION"+d+i[:id].to_s+d+i[:weight].to_s+d+i[:description]+"\n"
			else
				w a+"LINES"+d+"LOG"+d+i.to_s+"\n"
			end
		end
		pGroup.tail.each { |key,value| w a+"TAIL"+d+key.to_s+d+value.to_s+"\n" }
	end
end

	
