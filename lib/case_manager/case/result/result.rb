# frozen_string_literal: true

require_relative 'ext_array'
require_relative 'ext_compare'
require_relative 'ext_filter'

# This object contains data returned by remote/local execution
# * initialize
# * reset
class Result
  attr_reader :content
  attr_accessor :exitstatus

  def initialize
    reset
  end

  def reset
    @content_backup = []
    @content        = []
    @exitstatus     = nil
    @value          = nil
    @expected       = nil
    @alterations    = []
  end

  def ok?
    @exitstatus == 0
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
    if @content.class == Array
      debug_array
    else
      debug_no_array
    end
  end

  def debug_array
    print "*" * 20
    print " [DEBUG] count=#{@content.count} "
    puts "*" * 20
    @content.each_with_index do |item, index|
      puts format("[%2d] %s", index, item)
    end
    puts "*" * 57
  end

  def debug_no_array(mst)
    print "*" * 20
    print "[DEBUG] value=#{@content.to_s} (#{@content.class.to_s})"
    puts "*" * 20
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
  alias restore restore!

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
