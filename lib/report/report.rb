
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
    # @history save 1 letter for every target.
    # For example: "..F." means: good, good, fail and good
    # I will use this in the future stats manager.
    @history = ''
  end

  def export(format = :txt)
    @format = format
    filepath = File.join(@output_dir, @filename + '.' \
             + FormatterFactory.ext(@format))

    @formatter = FormatterFactory.get(self, @format, filepath)
    @formatter.process
  end

  def export_resume(format = :txt)
    @format = "resume_#{format.to_s}".to_sym
    filepath = File.join(@output_dir, @filename + '.' \
             + FormatterFactory.ext(@format))
    @formatter = FormatterFactory.get(self, @format, filepath)
    @formatter.process
  end
end
