require_relative "expect_sequence"

module CheckDSL
  def expect(cond)
    Logger.warn "    \u{1f6c8} 'expect' with no previous 'target'" unless @target_begin
    Logger.puts "      alter       #{result.alterations}" unless result.alterations.empty?
    Logger.puts "      expect      #{cond} (#{cond.class})"
    @target_begin = false
  end

  def expect_exit(cond)
    Logger.warn "    \u{1f6c8} 'expect' with no previous 'target'" unless @target_begin
    Logger.puts "      expect_exit #{cond} (#{cond.class})"
    @target_begin = false
  end

  def expect_fail
    Logger.warn "    \u{1f6c8} 'expect' with no previous 'target'" unless @target_begin
    Logger.puts "      expect_fail"
    @target_begin = false
  end

  def expect_first(cond)
    Logger.warn "    \u{1f6c8} 'expect' with no previous 'target'" unless @target_begin
    Logger.puts "      alter        #{result.alterations}" unless result.alterations.empty?
    Logger.puts "      expect_first #{cond} (#{cond.class})"
    @target_begin = false
  end

  def expect_last(cond)
    Logger.warn "    \u{1f6c8} 'expect' with no previous 'target'" unless @target_begin
    Logger.puts "      alter        #{result.alterations}" unless result.alterations.empty?
    Logger.puts "      expect_last #{cond} (#{cond.class})"
    @target_begin = false
  end

  def expect_none(cond = nil, args = {})
    Logger.warn "    \u{1f6c8} 'expect' with no previous 'target'" unless @target_begin
    Logger.puts "      alter       #{result.alterations}" unless result.alterations.empty?
    Logger.puts "      expect_none #{cond} (#{cond.class})"
    @target_begin = false
  end

  def expect_nothing
    expect_none nil, {}
  end

  def expect_ok
    expect_exit 0
  end

  def expect_one(cond)
    Logger.warn "    \u{1f6c8} 'expect' with no previous 'target'" unless @target_begin
    Logger.puts "      alter       #{result.alterations}" unless result.alterations.empty?
    Logger.puts "      expect_one  #{cond} (#{cond.class})"
    @target_begin = false
  end

  def expect_sequence(&block)
    Logger.warn "    \u{1f6c8} 'expect' with no previous 'target'" unless @target_begin
    seq = CheckDSL::ExpectSequence.new
    seq.is_valid?(&block)
    Logger.puts "      expect_sequence #{seq.expected}"
    @target_begin = false
  end
end
