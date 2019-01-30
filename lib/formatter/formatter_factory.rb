# encoding: utf-8

require_relative 'colored_text_formatter'
require_relative 'csv_formatter'
require_relative 'html_formatter'
require_relative 'txt_formatter'
require_relative 'yaml_formatter'
require_relative 'xml_formatter'

module FormatterFactory

  def FormatterFactory.get(pReport, pFormat, pFilename)
    case pFormat
		when :colored_text
      f=ColoredTextFormatter.new(pReport)
    when :csv
      f=CSVFormatter.new(pReport)
    when :html
      f=HTMLFormatter.new(pReport)
    when :txt
      f=TXTFormatter.new(pReport)
		when :yaml
      f=YAMLFormatter.new(pReport)
    when :xml
      f=XMLFormatter.new(pReport)
    end
    f.init(pFilename)
    return f
  end
end
