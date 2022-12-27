require_relative "txt"

class ColoredTextFormatter < TXTFormatter
  def initialize(report)
    super(report, true)
  end
end
