# frozen_string_literal: true

require 'json/pure'
require_relative 'array_formatter'

# JSONFormatter class
class JSONFormatter < ArrayFormatter
  def initialize(report)
    super(report)
    @data = {}
  end

  def process
    build_data
    w @data.to_json # Write data into ouput file
    deinit
  end
end
