# frozen_string_literal: true

require_relative "../result/sequence"

module DSL
  # expect <condition>, :weight => <value>
  def expect(input, args = {})
    if input.instance_of?(TrueClass) || input.instance_of?(FalseClass)
      expect2(input, args)
    elsif input.instance_of?(String) || input.instance_of?(Regexp) || input.instance_of?(Array)
      expect_any input
    else
      puts Rainbow("[TypeError] expect #{input} (#{input.class})").red
    end
  end

  def expect2(cond, args = {})
    @action_counter += 1
    @action[:id] = @action_counter
    if @result.exitcode < 0
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

    c = Settings.letter[:bad]
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

  def expect_exit(value)
    @result.alterations = "Read exit code"
    real_value = result.exitcode
    cond = if value.is_a? Range
      expect_value = "With range #{value}"
      value.to_a.include? real_value
    elsif value.is_a? Array
      expect_value = "Inside list #{value}"
      value.include? real_value
    else
      expect_value = value
      (real_value == value.to_i)
    end
    expect2 cond, value: real_value, expected: expect_value
  end

  def expect_fail
    @result.alterations = "Read exit code"
    real_value = result.exitcode
    expect_value = "Greater than 0"
    cond = (real_value > 0)
    expect2 cond, value: real_value, expected: expect_value
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

  def expect_ok
    expect_exit 0
  end

  def expect_sequence(&block)
    ok = "Sequence OK"
    err = "Sequence ERROR"
    seq = Sequence.new(result.content.dup)
    cond = seq.is_valid?(&block)
    result.alterations = seq.alterations
    status = err
    status = ok if cond
    expect2 cond, value: status, expected: ok
  end

  def weight(value = nil)
    # Set weight value for the action
    if value.nil?
      @action[:weight]
    elsif value == :default
      @action[:weight] = 1.0
    else
      @action[:weight] = value.to_f
    end
  end
end
