# frozen_string_literal: true

require 'yaml'
require_relative 'array_formatter'

##
# YAMLFormatter class receive a [Report] and generates YAML output.
class YAMLFormatter < ArrayFormatter
  ##
  # Class constructor
  # @param report [Report] Parent object that contains data to be exported.
  def initialize(report)
    super(report)
    @data = {}
  end

  ##
  # Process data from parent object and export it into YAML format.
  # @return [nil]
  def process
    build_data
    w @data.to_yaml # Write data into ouput file
    deinit
  end
end
