# DSL#expect, DSL#weight
module DSL
  # expect <condition>, :weight => <value>
  def expect2(cond, args = {})
    unless cond.class == TrueClass || cond.class = FalseClass
      puts "expect2 with text"
    end
    expect(cond, args)
  end

  def expect(cond, args = {})
    weight(args[:weight])

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
    verbose c
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
