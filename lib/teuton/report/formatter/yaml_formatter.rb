# frozen_string_literal: true

require 'yaml'
require_relative 'array_formatter'

# YAMLFormatter class
class YAMLFormatter < ArrayFormatter
  def initialize(report)
    super(report)
    @data = {}
  end

  def process
    build_data
    w @data.to_yaml # Write data into ouput file
    deinit
  end
end
