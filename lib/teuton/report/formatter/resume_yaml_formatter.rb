
require_relative 'resume_array_formatter'

##
# ResumeHTMLFormatter class
class ResumeYAMLFormatter < ResumeArrayFormatter
  ##
  # Initialize class
  # @param report (Report)
  def initialize(report)
    super(report)
    @data = {}
  end

  ##
  # Process resume report
  def process
    build_data
    w @data.to_yaml # Write data into ouput file
    deinit
  end
end
