# frozen_string_literal: true

require_relative 'ext_array'
require_relative 'ext_compare'
require_relative 'ext_filter'

# This object contains data returned by remote/local execution
# * initialize
# * alterations
# * content
# * debug
# * ok?
# * reset
# * restore
# * value
class Result
  attr_reader :content
  attr_accessor :exitstatus

  def initialize
    reset
  end

  def alterations
    @alterations.join(' & ')
  end

  def content=(content)
    @content_backup = content.clone
    @content = content.clone
  end

  def debug
    print "\n" + '*' * 20
    print " [DEBUG] count=#{@content.count} "
    puts '*' * 20
    @content.each_with_index do |item, index|
      puts format('%<index>2d: %<item>s', { index: index, item: item })
    end
    puts '*' * 57
  end

  def expected
    @expected.to_s
  end

  def first!
    @content = [@content.first]
  end

  def last!
    @content = [@content.last]
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
    return false if @exitstatus.nil?

    @exitstatus.zero?
  end

  def restore
    temp = @content_backup.clone
    reset
    @content_backup = temp
    @content        = temp.clone
  end
  alias restore! restore

  def value
    @content[0]
  end
end
