require "json/pure"
require_relative "array_formatter"

class JSONFormatter < ArrayFormatter
  def process
    build_data
    w @data.to_json # Write data into ouput file
    deinit
  end
end
