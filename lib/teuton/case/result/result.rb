# frozen_string_literal: true

require_relative "ext_array"
require_relative "ext_compare"
require_relative "ext_filter"

class Result
  attr_reader :content
  attr_accessor :exitcode
  attr_writer :alterations

  def initialize
    reset
  end

  def reset
    @content_backup = []
    @content = []
    @exitcode = -1
    @value = nil
    @expected = nil
    @alterations = []
  end

  def alterations
    if @alterations.is_a? String
      @alterations
    else
      @alterations.join(" & ")
    end
  end

  def content=(content)
    @content_backup = content.clone
    @content = content.clone
  end

  def debug
    print "\n" + "*" * 20
    print " [DEBUG] count=#{@content.count} "
    puts "*" * 20
    @content.each_with_index do |item, index|
      puts format("%<index>2d: %<item>s", {index: index, item: item})
    end
    puts "*" * 57
  end

  def expected
    @expected.to_s
  end

  def ok?
    @exitcode.zero?
  end

  def restore
    temp = @content_backup.clone
    reset
    @content_backup = temp
    @content = temp.clone
  end
  alias_method :restore!, :restore

  def value
    @content[0]
  end
end
