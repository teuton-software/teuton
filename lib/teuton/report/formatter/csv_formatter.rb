require_relative "base_formatter"

class CSVFormatter < BaseFormatter
	def process
		d = ";"
		@head.each { |key, value| w "HEAD#{d}#{key}#{d}#{value}\n" }
		@datagroups.each { |item| process_datagroup(item,d) }
		@tail.each { |key, value| w "TAIL#{d}#{key}#{d}#{value}\n" }
		deinit
	end

	def process_datagroup(group, delimiter = ";")
		d = delimiter
		a = "DATAGROUP#{group.order}#{d}"
		group.head.each { |key, value| w "#{a}HEAD#{d}#{key}#{d}#{value}\n" }
		group.lines.each do |i|
			if i.instance_of? Hash
				w "#{a}LINES#{d}ACTION#{d}#{i[:id]}#{d}#{i[:weight]}#{d}#{i[:description]}\n"
			else
        w "#{a}LINES#{d}LOG#{d}#{i}\n"
			end
		end
		group.tail.each { |key, value| w "#{a}TAIL#{d}#{key}#{d}#{value}\n" }
	end
end
