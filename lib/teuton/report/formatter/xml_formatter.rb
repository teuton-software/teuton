
require_relative 'base_formatter'

class XMLFormatter < BaseFormatter

	def initialize(pReport)
		super(pReport)
	end

	def process
		tab="  "
		w "<tt-checker version='0.2'>\n"
		w tab+"<head>\n"
		@head.each { |key,value| w tab*2+"<"+key.to_s+">"+value.to_s+"</"+key.to_s+">\n" }
		w tab+"</head>\n"

		w tab+"<lines>\n"
		@lines.each do |i|
			if i.class.to_s=='Hash' then
				w tab*2+"<line>\n"
				w tab*3+"<id>"+i[:id].to_s+"</id>\n"
				w tab*3+"<description>"+i[:description].to_s+"</description>\n"
				w tab*3+"<command"
				w " tempfile='"+i[:tempfile]+"'" if i[:tempfile]
				w ">"+i[:command].to_s+"</command>\n"
				w tab*3+"<check>"+i[:check].to_s+"</check>\n"
				w tab*3+"<weigth>"+i[:weight].to_s+"</weigth>\n"
				w tab*2+"</line>\n"
			else
				w tab*2+"<line type='log'>"+i.to_s+"</line>\n"
			end
		end
		w tab+"</lines>\n"

		w tab+"<tail>\n"
		@tail.each { |key,value| w tab*2+"<"+key.to_s+">"+value.to_s+"</"+key.to_s+">\n" }
		w tab+"</tail>\n"
		w "</tt-checker>\n"

		deinit
	end
end
