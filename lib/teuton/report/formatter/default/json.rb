# require "json/pure"
require "json"
require_relative "array"

class JSONFormatter < ArrayFormatter
  def initialize(report)
    super
    @ext = "json"
  end

  def process(options = {})
    build_data(options)
    w @data.to_json # Write data into ouput file
    deinit
  end
end
