
require 'terminal-table'
require_relative '../application'
require_relative 'formatter/formatter_factory'
require_relative 'show'
require_relative 'close'

=begin
 This class maintain the results of every case, in a structured way.
 * report/show.rb
 * report/close.rb
=end

class Report
  attr_accessor :id, :filename, :output_dir
  attr_accessor :head, :lines, :tail
  attr_reader :history
  attr_reader :format

  def initialize(id=0)
    @id = id
    number = '0' + @id.to_s
    number = @id.to_s if @id > 9
    @filename = "case-#{number}"
    @output_dir = Application.instance.output_basedir
    @head    = {}
    @lines   = []
    @tail    = {}
    @history = '' # Used by ??? (revise this!)
  end

  def export(format = :txt)
    @format = format
    filepath = File.join(@output_dir, @filename + '.' + @format.to_s)

    @formatter = FormatterFactory.get(self, @format, filepath)
    @formatter.process
  end
end
