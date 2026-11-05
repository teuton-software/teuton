require "yaml"
require_relative "hash"

class YAMLFormatter < HashFormatter
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
