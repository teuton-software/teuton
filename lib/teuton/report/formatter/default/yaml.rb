require "yaml"
require_relative "array"

class YAMLFormatter < ArrayFormatter
  def initialize(report)
    super(report)
    @ext = "yaml"
  end

  def process
    build_data
    w @data.to_yaml # Write data into ouput file
    deinit
  end
end
