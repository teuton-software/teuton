# frozen_string_literal: true

require 'terminal-table'
require_relative '../application'
require_relative 'formatter/formatter_factory'
require_relative 'show'
require_relative 'close'

##
# This class maintain the results of every case, in a structured way.
# * report/show.rb
# * report/close.rb
class Report
  # @!attribute id
  #   @return [Integer] It is the [Case] number. Zero indicates Resume Report.
  attr_accessor :id, :filename, :output_dir
  # @!attribute head
  #   @return [Hash] Report head information.
  attr_accessor :head
  # @!attribute lines
  #   @return [Array] Report body information.
  attr_accessor :lines
  # @!attribute tail
  #   @return [Hash] Report tail information.
  attr_accessor :tail
  # @!attribute format
  #   @return [Symbol] Indicate export format.
  attr_reader :format
  attr_reader :history
  ##
  # Class constructor
  def initialize(id = '00')
    @id = id
    @filename = "case-#{@id}"
    @output_dir = Application.instance.output_basedir
    @head = {}
    @lines = []
    @tail = {}
    # @history save 1 letter for every target.
    # For example: "..F." means: good, good, fail and good
    # I will use this in the future stats manager.
    @history = ''
  end

  ##
  # Export [Case] data to specified format.
  # @param format [Symbol] Select export format. Default value is :txt.
  def export(format = :txt)
    @format = format
    filepath = File.join(@output_dir, @filename + '.' \
             + FormatterFactory.ext(@format))

    formatter = FormatterFactory.get(self, @format, filepath)
    formatter.process
  end

  ##
  # Export resumed data from all Cases, to specified format.
  # @param format [Symbol] Select export format. Default value is :txt.
  def export_resume(format = :txt)
    @format = "resume_#{format}".to_sym
    filepath = File.join(@output_dir, @filename + '.' \
             + FormatterFactory.ext(@format))
    formatter = FormatterFactory.get(self, @format, filepath)
    formatter.process

    filepath = File.join(@output_dir, 'moodle.csv')
    formatter = FormatterFactory.get(self, :moodle_csv, filepath)
    formatter.process
  end
end
