# frozen_string_literal: true

require 'erb'
require_relative 'yaml_formatter'
require_relative '../../application'

##
# HTMLFormatter class receive a [Report] and generates HAML output.
class HTMLFormatter < YAMLFormatter
  ##
  # Class constructor
  # @param report [Report] Parent object that contains data to be exported.
  def initialize(report)
    super(report)
    @data = {}
    filepath = File.join(File.dirname(__FILE__), '..', '..', 'files', 'template', 'case.html')
    @template = File.read(filepath)
  end

  ##
  # Process data from parent object and export it into YAML format.
  def process
    build_data
    build_page
    deinit
  end

  ##
  # Build html case page
  def build_page
    config = @data[:config]
    results = @data[:results]
    logs = @data[:logs]
    groups = @data[:groups]
    groups = @data[:groups]
    hall_of_fame = @data[:hall_of_fame]
    version = Application::VERSION
    renderer = ERB.new(@template)
    w renderer.result(binding)
  end
end
