# frozen_string_literal: true

require_relative 'resume_yaml_formatter'
require 'erb'

##
# HTMLFormatter class receive a [Report] and generates HAML output.
class ResumeHTMLFormatter < ResumeYAMLFormatter
  ##
  # Class constructor
  # @param report [Report] Parent object that contains data to be exported.
  def initialize(report)
    super(report)
    @data = {}
  end

  ##
  # Process data from parent object and export it into YAML format.
  def process
    build_data
    build_page
    deinit
  end

  def build_page
    config = @data[:config]
#    renderer = ERB.new(File.read(filepath))
#    page = renderer.result(binding)
    w "UNDER CONSTRUCTION!!!"
  end
end
