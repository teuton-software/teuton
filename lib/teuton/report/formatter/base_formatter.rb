class BaseFormatter
  def initialize(report)
    @head = report.head
    @lines = report.lines
    @tail = report.tail
  end

  def process
    raise "Empty method!"
  end

  def init(filename)
    @filename = filename
    @file = File.open(@filename, "w")
  end

  ##
  # Write data into output file
  # @param text (String) Text data to write into output file
  def w(text)
    @file.write text.to_s
  end

  def deinit
    @file.close
  end

  def trim(input)
    output = input.to_s
    output = "...#{input[input.size - 50, input.size]}" if output.size > 65
    output.to_s
  end
end
