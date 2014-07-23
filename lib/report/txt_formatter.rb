#!/usr/bin/ruby
# encoding: utf-8

require_relative 'base_formatter'

class TXTFormatter < BaseFormatter
	
	def initialize(pReport)
		super(pReport)
	end
		
	def process
		tab="  "
		w "HEAD\n"
		@head.each { |key,value| w tab+key.to_s+": "+value.to_s+"\n" }

		w "HISTORY\n"
		@lines.each do |i|
			if i.class.to_s=='Hash' then
				lValue=i[:weight] if i[:check]
				w tab+i[:id].to_s+" ("+lValue.to_s+"/"+i[:weight].to_s+") "
				w '"'+i[:description].to_s+'": '+i[:command].to_s+"\n"
			else
				w tab+"- "+i.to_s+"\n"
			end
		end

		w "TAIL\n"
		@tail.each { |key,value| w tab+key.to_s+": "+value.to_s+"\n" }
		deinit

	end
end

