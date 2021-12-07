# frozen_string_literal: true

# BaseFormatter class
class BaseFormatter
  ##
  # Initialize class
  # @param report (Report) Format report data
  def initialize(report)
    @head = report.head
    @lines = report.lines
    @tail = report.tail
  end

  ##
  # Execute format action
  def process
    raise 'Empty method!'
  end

  ##
  # Creates new output file
  # @param filename (String) Path to output file
  def init(filename)
    @filename = filename
    @file = File.open(@filename, 'w')
  end

  ##
  # Write data into output file
  # @param text (String) Text data to write into output file
  def w(text)
    @file.write text.to_s
  end

  ##
  # Close open output file
  def deinit
    @file.close
  end

  def trim(input)
    output = input.to_s
    output = "...#{input[input.size - 50, input.size]}" if output.size > 65
    output.to_s
  end
end
