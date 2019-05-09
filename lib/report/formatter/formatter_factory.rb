
require_relative 'colored_text_formatter'
require_relative 'csv_formatter'
require_relative 'html_formatter'
require_relative 'json_formatter'
require_relative 'txt_formatter'
require_relative 'yaml_formatter'
require_relative 'xml_formatter'

module FormatterFactory

  def FormatterFactory.get(report, format, filename)
    case format
		when :colored_text
      f = ColoredTextFormatter.new(report)
    when :csv
      f = CSVFormatter.new(report)
    when :html
      f = HTMLFormatter.new(report)
    when :json
      f = JSONFormatter.new(report)
    when :txt
      f = TXTFormatter.new(report)
		when :yaml
      f = YAMLFormatter.new(report)
    when :xml
      f = XMLFormatter.new(report)
    end
    f.init(filename)
    return f
  end
end
