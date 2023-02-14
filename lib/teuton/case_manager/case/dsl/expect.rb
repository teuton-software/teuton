# frozen_string_literal: true

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

  def expect_none(input, args = {})
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
