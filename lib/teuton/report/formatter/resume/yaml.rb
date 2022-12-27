require_relative "array"

class ResumeYAMLFormatter < ResumeArrayFormatter
  def initialize(report)
    super(report)
    @ext = "yaml"
    @data = {}
  end

  def process
    build_data
    w @data.to_yaml # Write data into ouput file
    deinit
  end
end
