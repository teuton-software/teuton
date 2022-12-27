require "json/pure"
require_relative "array"

class ResumeJSONFormatter < ResumeArrayFormatter
  def initialize(report)
    super(report)
    @ext = "json"
    @data = {}
  end

  def process(options = {})
    build_data(options)
    w @data.to_json # Write data into ouput file
    deinit
  end
end
