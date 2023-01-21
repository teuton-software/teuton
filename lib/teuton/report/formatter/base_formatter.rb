class BaseFormatter
  attr_reader :ext
  
  def initialize(report)
    @head = report.head.clone
    @lines = report.lines.clone
    @tail = report.tail.clone
    @ext = "unkown"
  end

  def process(options = {})
    raise "Empty method!"
  end

  def init(filename)
    @filename = "#{filename}.#{@ext}"
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
