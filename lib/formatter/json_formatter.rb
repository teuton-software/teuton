# encoding: utf-8

require_relative 'yaml_formatter'

class JSONFormatter < YAMLFormatter

  def initialize(pReport)
    super(pReport)
    @data = {}
  end

  def process
    build_data
    w @data.to_json # Write data into ouput file
    deinit
  end

end
