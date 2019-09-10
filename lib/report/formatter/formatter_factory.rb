# frozen_string_literal: true

require_relative 'csv_formatter'
require_relative 'html_formatter'
require_relative 'json_formatter'
require_relative 'txt_formatter'
require_relative 'yaml_formatter'
require_relative 'xml_formatter'
require_relative 'resume_txt_formatter'

# FormaterFactory module
module FormatterFactory
  def self.get(report, format, filename)
    case format
    when :colored_text
      f = TXTFormatter.new(report,true)
    when :csv
      f = CSVFormatter.new(report)
    when :html
      f = HTMLFormatter.new(report)
    when :json
      f = JSONFormatter.new(report)
    when :resume_txt
      f = ResumeTXTFormatter.new(report, false)
    when :resume_colored_text
      f = ResumeTXTFormatter.new(report, true)
    when :txt
      f = TXTFormatter.new(report,false)
    when :yaml
      f = YAMLFormatter.new(report)
    when :xml
      f = XMLFormatter.new(report)
    end
    f.init(filename)
    f
  end

  def self.ext(format)
    data = {}
    data[:txt] = 'txt'
    data[:colored_text] = 'txt'
    data[:resume_txt] = 'txt'
    data[:resume_colored_text] = 'txt'
    data[:cvs] = 'csv'
    data[:resume_csv] = 'csv'
    return format.to_s if data[format].nil?
    
    data[format]
  end
end
