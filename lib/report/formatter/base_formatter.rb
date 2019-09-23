# frozen_string_literal: true

# BaseFormatter class
class BaseFormatter
  def initialize(report)
    @head = report.head
    @lines = report.lines
    @tail = report.tail
  end

  def init(filename)
    @filename = filename
    @file = File.open(@filename, 'w')
  end

  def w(text)
    @file.write text.to_s # write into output file
  end

  def process
    raise 'Empty method!'
  end

  def deinit
    @file.close
  end

  def trim_center(input)
    output = input.to_s
    return output if output.size<65
    output = input[0,10] + '...' + input[input.size-50, input.size]
    output.to_s
  end
end
