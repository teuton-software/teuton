# frozen_string_literal: true

require_relative 'result/ext_array'
require_relative 'result/ext_compare'
require_relative 'result/ext_filter'

# This object contains data returned by remote/local execution
class Result
  attr_reader :content
  attr_writer :ok

  def initialize
    reset
  end

  def reset
    @content_backup = []
    @content        = []
    @ok             = false
    @value          = nil
    @expected       = nil
    @alterations    = []
  end

  def ok?
    @ok
  end

  def alterations
    return '' if @alterations.size.zero?

    @alterations.join(' & ')
  end

  def content=(content)
    @content_backup = content.clone
    @content = content.clone
  end

  def debug
    my_screen_table = Terminal::Table.new do |st|
      if @content.class == Array
        debug_array(st)
      else
        debug_no_array(st)
      end
    end
    puts '\n' + my_screen_table.to_s + '\n'
  end

  def debug_array(mst)
    mst.add_row ["count=#{@content.count}", 'result.debug()']
    mst.add_separator
    i = 0
    @content.each do |item|
      mst.add_row ['Line_' + i.to_s, item]
      i += 1
    end
  end

  def debug_no_array(mst)
    mst.add_row ['', 'result.debug()']
    mst.add_separator
    mst.add_row [@content.class.to_s, @content.to_s]
  end

  def expected
    @expected.to_s
  end

  def restore!
    temp = @content_backup.clone
    reset
    @content_backup = temp
    @content        = temp.clone
  end

  def value
    @content[0]
  end

  # Return 'true' if the parameter value is near to the target value.
  # To get this we consider a 10% desviation or less, as an acceptable result.
  def near_to?(value)
    @expected = "Is near to #{value}"
    return false if @content.nil?

    target = @content[0].to_f
    desv   = (target * 10.0) / 100.0
    return true if (target - value.to_f).abs.to_f <= desv

    false
  end
  alias near? near_to?
end
