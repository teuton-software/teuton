# frozen_string_literal: true

require "erb"
require_relative "resume_yaml_formatter"
require_relative "../../application"

##
# HTMLFormatter class receive a [Report] and generates HTML output.
class ResumeHTMLFormatter < ResumeYAMLFormatter
  def initialize(report)
    super(report)
    @data = {}
    filepath = File.join(File.dirname(__FILE__), "..", "..", "files", "template", "resume.html")
    @template = File.read(filepath)
  end

  def process
    build_data
    build_page
    deinit
  end

  def build_page
    render = ERB.new(@template)
    w render.result(binding)
  end

  private

  def config
    @data[:config]
  end

  def cases
    @data[:cases]
  end

  def results
    @data[:results]
  end

  def hall_of_fame
    @data[:hall_of_fame]
  end

  def version
    Application::VERSION
  end
end
