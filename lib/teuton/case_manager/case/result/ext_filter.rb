# frozen_string_literal: true

# This is an extension of Result class
class Result
  # TODO: Error line 102 undefined include? method for 0 Fixnum...
  def find(filter)
    @alterations << "find(#{filter})"
    case filter.class.to_s
    when 'Array'
      find_when_array(filter)
    when 'String' || 'Integer'
      @content.select! { |i| i.include?(filter.to_s) }
    when 'Regexp'
      @content.select! { |i| filter.match(i) }
    end
    self
  end
  alias grep   find
  alias grep!  find
  alias find!  find

  def not_find(p_filter)
    @alterations << "not_find(#{p_filter})"
    return self if @content.size.zero?

    @content.reject! { |i| i.include?(p_filter) }
    self
  end
  alias grep_v not_find

  def since(filter)
    @alterations << "since(#{filter})"
    return self if @content.size.zero?

    if filter.class == String
      flag = false
      @content.select! do |i|
        flag = true if i.include?(filter.to_s)
        flag
      end
    end
    self
  end

  def until(filter)
    @alterations << "until(#{filter})"
    return self if @content.size.zero?

    if filter.class == String
      flag = true
      @content.select! do |i|
        flag = false if i.include?(filter.to_s)
        flag
      end
    end
    self
  end

  private

  def find_when_array(filter)
    @content.select! do |line|
      flag = false
      filter.each { |i| flag ||= line.include?(i) }
      flag
    end
  end
end
