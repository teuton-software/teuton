# frozen_string_literal: true

class Result
  def find(filter)
    @alterations << "find(#{filter})"
    case filter.class.to_s
    when "Array"
      find_when_array(filter)
    when "String" || "Integer"
      @content.select! { |i| i.include?(filter.to_s) }
    when "Regexp"
      @content.select! { |i| filter.match(i) }
    end
    self
  end
  alias_method :grep, :find
  alias_method :grep!, :find
  alias_method :find!, :find

  def first
    @alterations << "first"
    @content = [@content.first]
    self
  end

  def not_find(filter)
    @alterations << "not_find(#{filter})"
    return self if @content.size.zero?

    case filter.class.to_s
    when "Array"
      filter.each { |i| not_find(i.to_s) }
    when "String" || "Integer"
      @content.reject! { |i| i.include?(filter.to_s) }
    when "Regexp"
      @content.reject! { |i| filter.match(i) }
    end
    self
  end
  alias_method :grep_v, :not_find

  def since(filter)
    @alterations << "since(#{filter})"
    return self if @content.size.zero?

    if filter.instance_of? String
      flag = false
      @content.select! do |i|
        flag = true if i.include?(filter.to_s)
        flag
      end
    end
    self
  end

  def last
    @alterations << "last"
    @content = [@content.last]
    self
  end

  def until(filter)
    @alterations << "until(#{filter})"
    return self if @content.size.zero?

    if filter.instance_of? String
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
