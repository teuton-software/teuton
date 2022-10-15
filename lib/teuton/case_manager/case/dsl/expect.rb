# frozen_string_literal: true

require 'colorize'

module DSL
  # expect <condition>, :weight => <value>
  def expect(input, args = {})
    if input.class == TrueClass || input.class == FalseClass
      expect2(input, args)
    elsif input.class == String || input.class == Regexp || input.class == Array
      expect_any input
    else
      puts "[TypeError] expect #{input} (#{input.class})"
    end
  end

  def expect2(cond, args = {})
    @action_counter += 1
    @action[:id] = @action_counter
    @action[:check] = cond
    @action[:result] = @result.value

    @action[:alterations] = @result.alterations
    @action[:expected] = @result.expected
    @action[:expected] = args[:expected] if args[:expected]

    @report.lines << @action.clone
    weight(1.0)

    app = Application.instance
    c = app.letter[:bad]
    c = app.letter[:good] if cond
    verbose c.colorize(:green)
  end

  def expect_any(input, args = {})
    if input.class == Array
      input.each { |i| result.find(i) }
    else
      result.find(input)
    end
    expect2 result.count.gt(0), args
  end

  def expect_first(input, args = {})
    @result.first
    output = input
    output = args[:expected] if args[:expected]
    expect2 input, expected: output
  end

  def expect_last(input, args = {})
    @result.last
    output = input
    output = args[:expected] if args[:expected]
    expect2 input, expected: output
  end

  def expect_none(input, args = {})
    if input.class == Array
      input.each { |i| result.find(i) }
    else
      result.find(input)
    end
    expect2 result.count.eq(0), args
  end

  def expect_one(input, args = {})
    if input.class == Array
      input.each { |i| result.find(i) }
    else
      result.find(input)
    end
    expect2 result.count.eq(1), args
  end

  # Set weight value for the action
  def weight(value = nil)
    if value.nil?
      @action[:weight]
    elsif value == :default
      @action[:weight] = 1.0
    else
      @action[:weight] = value.to_f
    end
  end
end
