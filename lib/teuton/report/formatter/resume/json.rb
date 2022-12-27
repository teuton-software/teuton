require "json/pure"
require_relative "array"

class ResumeJSONFormatter < ResumeArrayFormatter
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
