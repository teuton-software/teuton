
require_relative 'base_formatter'

class CSVFormatter < BaseFormatter
	def initialize(report)
		super(report)
	end

	def process
		d = ';'
		@head.each { |key,value| w "HEAD#{d}#{key}#{d}#{value}\n" }
		@datagroups.each { |item| process_datagroup(item,d) }
		@tail.each { |key,value| w "TAIL#{d}#{key}#{d}#{value}\n" }
		deinit
	end

	def process_datagroup(pGroup, delimiter=';')
		d = delimiter
		a = "DATAGROUP"+pGroup.order.to_s+d
		pGroup.head.each { |key,value| w a+"HEAD"+d+key.to_s+d+value.to_s+"\n" }
		pGroup.lines.each do |i|
			if i.class.to_s=='Hash' then
				w a + "LINES#{d}ACTION#{d}#{i[:id]}#{d}#{i[:weight]}#{d}" +
				      "#{i[:description]}\n"
			else
				w a + "LINES#{d}LOG#{d}#{i}\n"
			end
		end
		pGroup.tail.each { |key,value| w a+"TAIL"+d+key.to_s+d+value.to_s+"\n" }
	end
end
