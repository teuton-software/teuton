
require 'yaml'
require_relative 'array_formatter'

class YAMLFormatter < ArrayFormatter

  def initialize(pReport)
    super(pReport)
    @data = {}
  end

  def process
    build_data
    w @data.to_yaml # Write data into ouput file
    deinit
  end

end
