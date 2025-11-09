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
  LIST = {
    colored_text: ColoredTextFormatter,
    html: HTMLFormatter,
    json: JSONFormatter,
    txt: TXTFormatter,
    xml: XMLFormatter,
    yaml: YAMLFormatter,
    moodle_csv: MoodleCSVFormatter,
    resume_colored_text: ResumeColoredTextFormatter,
    resume_html: ResumeHTMLFormatter,
    resume_json: ResumeJSONFormatter,
    resume_txt: ResumeTXTFormatter,
    resume_xml: ResumeTXTFormatter, # TODO
    resume_yaml: ResumeYAMLFormatter
  }

  def self.available_formats
    LIST.keys.take(6)
  end

  def self.call(report, options, filename)
    klass = get(options[:format])
    if klass.nil?
      puts "[ERROR] Formatter:"
      puts "        Unkown format <#{options[:format]}>. Fix line <export format: FORMAT>"
      puts "        Available formats: #{Formatter.available_formats.join(',')}."
      exit 1
    end
    formatter = klass.new(report)
    formatter.init(filename)
    report.format = formatter.ext
    formatter.process(options)
  end

  def self.get(format)
    LIST[format]
  end

  def self.hide_feedback(report)
    report2 = report.clone
    report2.groups.each do |group|
      group.each do |item|
        puts item
      end
    end
  end
end
