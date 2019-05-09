
require 'terminal-table'

class BaseFormatter

  def initialize(report)
    @head = report.head
    @lines = report.lines
    @tail = report.tail
  end

  def init(filename)
    @filename = filename
    @file = File.open(@filename,'w')
  end

  def w(text)
    #write into output file
    @file.write text.to_s
  end

  def process
    raise "Empty method!"
  end

  def deinit
    @file.close
  end
end
