# frozen_string_literal: true

require 'rainbow'

# DSL module:
# * expect_none
# * expect_one
# * expect_any
# * expect
# * expect2
# * weight
module DSL
  def expect_none(input)
    if input.class == Array
      input.each { |i| result.find(i) }
    else
      result.find(input)
    end
    expect2 result.count.eq(0)
  end

  def expect_one(input)
    if input.class == Array
      input.each { |i| result.find(i) }
    else
      result.find(input)
    end
    expect2 result.count.eq(1)
  end

  def expect_any(input)
    if input.class == Array
      input.each { |i| result.find(i) }
    else
      result.find(input)
    end
    expect2 result.count.gt(0)
  end

  # expect <condition>, :weight => <value>
  def expect(input, args = {})
    if input.class == TrueClass || input.class == FalseClass
      expect2(input, args)
    elsif input.class == String || input.class == Regexp || input.class == Array
      expect_any input
    else
      puts "[ERROR] expect #{input} (#{input.class})"
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
    verbose Rainbow(c).yellow.bright
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
