require "terminal-table"
require_relative "../application"
require_relative "formatter/formatter"
require_relative "close"

##
# This class maintains the results of every case, in a structured way.
# * report/close.rb
class Report
  attr_accessor :id, :filename, :output_dir
  attr_accessor :head
  attr_accessor :lines
  attr_accessor :tail
  attr_reader :format
  attr_reader :history

  def initialize(id = "00")
    @id = id
    @filename = "case-#{@id}"
    @output_dir = Application.instance.output_basedir
    @head = {}
    @lines = []
    @tail = {}
    # @history save 1 letter for every target.
    # For example: "..F." means: good, good, fail and good
    # I will use this in the future stats manager.
    @history = ""
  end

  def export(format = :txt, options = {})
    @format = format
    filepath = File.join(@output_dir, @filename)
    Formatter.call(self, @format, filepath)
  end

  def export_resume(format = :txt, options = {})
    @format = "resume_#{format}".to_sym
    filepath = File.join(@output_dir, @filename)
    Formatter.call(self, @format, filepath)

    filepath = File.join(@output_dir, "moodle")
    Formatter.call(self, :moodle_csv, filepath)
  end
end
