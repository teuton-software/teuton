# frozen_string_literal: true

# This is an extension of Result class
class Result
  # TODO: Error line 102 undefined include? method for 0 Fixnum...
  def find(filter)
    @alterations << "find(#{filter})"
    find?(filter)
    self
  end

  def not_find(p_filter)
    @alterations << "not_find(#{p_filter})"
    return self if @content.size.zero?

    @content.reject! { |i| i.include?(p_filter) }
    self
  end

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

  alias grep   find
  alias grep!  find
  alias find!  find
  alias grep_v not_find

  private

  def find?(filter)
    case filter.class.to_s
    when 'Array'
      return find_when_array(filter)
    when 'String'
      return find_when_string(filter)
    when 'Integer'
      return find_when_string(filter.to_s)
    when 'Regexp'
      return find_when_regexp(filter)
    end
    false
  end

  def find_when_array(filter)
    return find?(filter[0]) if filter.size == 1
    @content.select! do |line|
      flag = false
      filter.each { |i| flag ||= find?(i) }
      flag
    end
    @content.size >= 0
  end

  def find_when_string(filter)
    # Error controlar include? en 0 Integer...
    @content.select! { |i| i.include?(filter.to_s) }
    @content.size >= 0
  end

  def find_when_regexp(filter)
    @content.select! { |i| filter.match(i) }
    @content.size >= 0
  end
end
