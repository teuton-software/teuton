require_relative "array"

class ResumeYAMLFormatter < ResumeArrayFormatter
  def initialize(report)
    super(report)
    @ext = "yaml"
    @data = {}
  end

  def process(options = {})
    build_data(options)
    w @data.to_yaml # Write data into ouput file
    deinit
  end
end
