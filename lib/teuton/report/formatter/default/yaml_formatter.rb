require "yaml"
require_relative "array_formatter"

class YAMLFormatter < ArrayFormatter
  ##
  # Process data from parent object and export it into YAML format.
  # @return [nil]
  def process
    build_data
    w @data.to_yaml # Write data into ouput file
    deinit
  end
end
