
require_relative 'array_formatter'

class JSONFormatter < ArrayFormatter

  def initialize(pReport)
    super(pReport)
    @data = {}
  end

  def process
    build_data
    w @data.to_json # Write data into ouput file
    deinit
  end

end
