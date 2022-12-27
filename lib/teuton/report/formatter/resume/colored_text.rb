require_relative "txt"

class ResumeColoredTextFormatter < ResumeTXTFormatter
  def initialize(report)
    super(report, true)
  end
end
