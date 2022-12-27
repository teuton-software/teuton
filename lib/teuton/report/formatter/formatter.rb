require "rainbow"
require_relative "default/colored_text"
require_relative "default/html"
require_relative "default/json"
require_relative "default/txt"
require_relative "default/xml"
require_relative "default/yaml"
require_relative "resume/colored_text"
require_relative "resume/html"
require_relative "resume/json"
require_relative "resume/txt"
require_relative "resume/yaml"
require_relative "moodle_csv_formatter"

module Formatter
  def self.call(report, format, filename)
    case format
    when :colored_text
      f = ColoredTextFormatter.new(report)
    when :html
      f = HTMLFormatter.new(report)
    when :json
      f = JSONFormatter.new(report)
    when :txt
      f = TXTFormatter.new(report)
    when :xml
      f = XMLFormatter.new(report)
    when :yaml
      f = YAMLFormatter.new(report)
    when :moodle_csv
      f = MoodleCSVFormatter.new(report)
    when :resume_txt
      f = ResumeTXTFormatter.new(report)
    when :resume_colored_text
      f = ResumeColoredTextFormatter.new(report)
    when :resume_json
      f = ResumeJSONFormatter.new(report)
    when :resume_html
      f = ResumeHTMLFormatter.new(report)
    when :resume_xml
      # TODO
      f = ResumeListFormatter.new(report)
    when :resume_yaml
      f = ResumeYAMLFormatter.new(report)
    else
      puts Rainbow("[ERROR] Unkown format: #{format}").red
      puts Rainbow("        export format: FORMAT").red
      exit 1
    end
    f.init(filename)
    f.process
  end

  def self.select(format)
    klasses = {
      colored_text: "ColoredTXTFormatter",
      json: JSONFormatter,
      txt: TXTFormatter,
      xml: "xml",
      yaml: "yaml",
      resume_colored_text: "txt",
      resume_csv: "csv",
      resume_json: "json",
      resume_html: "html",
      resume_txt: "txt",
      resume_xml: "xml",
      resume_yaml: "yaml"
    }
    return format.to_s if klasses[format].nil?

    klasses[format]
  end
end
