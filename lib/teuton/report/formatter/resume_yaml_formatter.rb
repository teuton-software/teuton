
require_relative 'resume_array_formatter'

# JSONFormatter class
class ResumeYAMLFormatter < ResumeArrayFormatter
  def initialize(report)
    super(report)
    @data = {}
  end

  def process
    build_data
    w @data.to_yaml # Write data into ouput file
    deinit
  end
end
