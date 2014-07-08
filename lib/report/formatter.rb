#!/usr/bin/ruby
# encoding: utf-8

require_relative 'csv_formatter'
require_relative 'html_formatter'
require_relative 'txt_formatter'
require_relative 'xml_formatter'

module FormatterProxy
	
	def FormatterProxy.new(pReport, pFormat, pFilename)
		f = CSVFormatter.new(pReport) if pFormat==:csv
		f = HTMLFormatter.new(pReport) if pFormat==:html
		f = TXTFormatter.new(pReport) if pFormat==:txt
		f = XMLFormatter.new(pReport) if pFormat==:xml
		f.init(pFilename)
		return f
	end	
end

