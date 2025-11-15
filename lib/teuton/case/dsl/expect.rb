# frozen_string_literal: true

require_relative "expect_exitcode"
require_relative "expect_sequence"

module DSL
  # expect <condition>,
  #      value: RealValue,
  #   expected: ExpectedValue,
  #     weight: float
  #
  def expect(input, args = {})
    if input.instance_of?(TrueClass) || input.instance_of?(FalseClass)
      expect2(input, args)
    elsif input.instance_of?(String) || input.instance_of?(Regexp) || input.instance_of?(Array)
      expect_any input
    else
      puts Rainbow("[ERROR] Case expect TypeError: expect #{input} (#{input.class})").red
    end
  end

  def expect2(cond, args = {})
    @action_counter += 1
    @action[:id] = @action_counter
    if @result.exitcode < 0
      # When exitcode is less than zero, it is because there has been
      # an error in the remote connection (SSH or Telnet)
      @action[:check] = false
      @action[:result] = @action[:output]
    else
      @action[:check] = cond
      @action[:result] = (args[:value] || @result.value)
    end

    @action[:alterations] = @result.alterations
    @action[:expected] = (args[:expected] || @result.expected)
    @report.lines << @action.clone
    weight(1.0)

    c = Settings.letter[:fail]
    c = Settings.letter[:good] if cond
    verbose Rainbow(c).green
  end

  def expect_any(input, args = {})
    if input.instance_of? Array
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

  def expect_nothing(args = {})
    expect2 result.count.eq(0), args
  end

  def expect_none(input = nil, args = {})
    if input.nil?
      # nothing to do
    elsif input.instance_of? Array
      input.each { |i| result.find(i) }
    else
      result.find(input)
    end
    expect2 result.count.eq(0), args
  end

  def expect_one(input, args = {})
    if input.instance_of? Array
      input.each { |i| result.find(i) }
    else
      result.find(input)
    end
    expect2 result.count.eq(1), args
  end

  def expect_sequence(&block)
    seq = ExpectSequence.new(result.content.dup)
    cond = seq.is_valid?(&block)
    expect2 cond, value: seq.real, expected: seq.expected
  end
end
