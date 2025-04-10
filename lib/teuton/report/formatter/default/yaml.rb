require "yaml"
require_relative "array"

class YAMLFormatter < ArrayFormatter
  def initialize(report)
    super
    @ext = "yaml"
  end

  def process(options = {})
    build_data(options)
    w @data.to_yaml # Write data into ouput file
    deinit
  end
end
