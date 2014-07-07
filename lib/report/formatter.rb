#!/usr/bin/ruby
# encoding: utf-8

#require_relative 'cvs_formatter'
	
module FormatterProxy
	
	def FormatterProxy.new(pReport, pFormat, pFilename)
		f = CSVFormatter.new(pReport) if pFormat==:csv
		f = HTMLFormatter.new(pReport) if pFormat==:html
		f = TXTFormatter.new(pReport) if pFormat==:txt
		f = XMLFormatter.new(pReport) if pFormat==:xml
		f.init(pFilename)
		return f
	end
	
	class BaseFormatter
		def initialize(pReport)
			@head = pReport.head
			@lines = pReport.lines
			@tail = pReport.tail
		end
		
		def init(pFilename)
			@filename=pFilename
			@file = File.open(@filename,'w')
		end
	
		def w(pText)
			#write into output file
			@file.write pText.to_s
		end
		
		def process
			raise "Empty method!"
		end
		
		def deinit
			@file.close
		end
	end
	
end
	
class HTMLFormatter < FormatterProxy::BaseFormatter
	
	def initialize(pReport)
		super(pReport)
	end
	
	def process
		puts "<html>"
		puts "<head><title>tt-checker</title></head>"
		puts "<body>"
		puts "<header><h1><a name=\"index\">tt-checker v0.2</a></h1>"
		puts '<ul>'
		@head.each do |key,value|
			puts "<li><b>"+key.to_s+": </b>"+value.to_s+"</li>" if key!=:title 
		end
		puts '</ul>'
		puts "<table border=1 >"
		puts "<thead><tr><td>Members</td><td>Grade</td><td>Fails</td></tr></thead>"
		puts "<tbody>"
		counter=0
		@datagroups.each do |i|
			counter+=1
			puts "<tr><td><a href=\"#group"+counter.to_s+"\">"+i.head[:members]+"</a></td>"
			puts "<td>"+i.tail[:grade].to_s+"</td>"
			puts "<td>"+i.tail[:fail_counter].to_s+"</td></tr>"
		end
		puts "</tbody></table></header>"
		puts "<h1>Cases</h1>"
		counter=0
		@datagroups.each do |i|
			counter+=1
			process_datagroup(i,counter)
		end
			
		puts '<ul>'
		@tail.each do |key,value|
			puts "<li><b>"+key.to_s+": </b>"+value.to_s+"</li>"
		end
		puts '</ul>'
		puts "</body></html>"
	end

	def process_datagroup(pGroup, pCounter)
		puts "<h2><a name=\"group"+pCounter.to_s+"\">Case members "+@head[:members]+"</a> (<a href=\"#index\">up</a>)</h2>"
		puts "<table border=1 >"
		puts "<thead><tr><td>Params</td><td>Results</td></tr></thead>"
		puts "<tbody><tr>"
		puts "<td><ul>"
		pGroup.head.each do |key,value|
			puts "<li><b>"+key.to_s+"</b>= "+value.to_s+"</li>" if key!=:members 
		end
		puts "</ul></td>"
		puts '<td><ul>'
		pGroup.tail.each do |key,value| 
			puts "<li><b>"+key.to_s+"</b>= "+value.to_s+"</li>"
		end
		puts '</ul></td>'
		
		puts '</tr></tbdody></table>'
		puts '<h3>Test log</h3>'
		puts '<ul>'
		pGroup.lines.each do |i|
			if i.class.to_s=='Hash' then
				value=0.0
				value=i[:weight] if i[:check]
				a="<li>"+i[:id].to_s+" ("+value.to_s+") [weight="+i[:weight].to_s+"] "
				a+="<i>"+i[:description]+"</i>: "+i[:command]+"</li>"
				puts a
			else
				puts "<li>"+i.to_s+"</li>"
			end
		end
		puts '</ul>'
	end
end

class TXTFormatter < FormatterProxy::BaseFormatter
	
	def initialize(pReport)
		super(pReport)
	end
		
	def process
		tab="  "
		w "HEAD\n"
		@head.each { |key,value| w tab+key.to_s+": "+value.to_s+"\n" }

		w "LINES\n"
		@lines.each do |i|
			if i.class.to_s=='Hash' then
				lValue=i[:weight] if i[:check]
				w tab+i[:id].to_s+" ("+lValue.to_s+"/"+i[:weight].to_s+") "
				w i[:description].to_s+" { "+i[:command].to_s+" }\n"
			else
				w tab+"- "+i.to_s+"\n"
			end
		end

		w "TAIL\n"
		@tail.each { |key,value| w tab+key.to_s+": "+value.to_s+"\n" }
		deinit

	end
end


class XMLFormatter < FormatterProxy::BaseFormatter
	
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
