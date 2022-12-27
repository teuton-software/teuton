require "json/pure"
require_relative "array"

class JSONFormatter < ArrayFormatter
  def initialize(report)
    super(report)
    @ext = "json"
  end

  def process
    build_data
    w @data.to_json # Write data into ouput file
    deinit
  end
end
