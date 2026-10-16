require_relative "expect_sequence"

module CheckDSL
  def expect(cond)
    Logger.warn "WARN  'expect' with no previous 'target'" unless @target_begin
    Logger.puts "      alter       #{result.alterations}" unless result.alterations.empty?
    Logger.puts "      expect      #{cond} (#{cond.class})"
    Logger.puts ""
    @target_begin = false
  end

  def expect_exit(cond)
    Logger.warn "WARN  'expect' with no previous 'target'" unless @target_begin
    Logger.puts "      expect_exit #{cond} (#{cond.class})"
    Logger.puts ""
    @target_begin = false
  end

  def expect_fail
    Logger.warn "WARN  'expect' with no previous 'target'" unless @target_begin
    Logger.puts "      expect_fail"
    Logger.puts ""
    @target_begin = false
  end

  def expect_first(cond)
    Logger.warn "WARN  'expect' with no previous 'target'" unless @target_begin
    Logger.puts "      alter        #{result.alterations}" unless result.alterations.empty?
    Logger.puts "      expect_first #{cond} (#{cond.class})"
    Logger.puts ""
    @target_begin = false
  end

  def expect_last(cond)
    Logger.warn "WARN  'expect' with no previous 'target'" unless @target_begin
    Logger.puts "      alter        #{result.alterations}" unless result.alterations.empty?
    Logger.puts "      expect_last #{cond} (#{cond.class})"
    Logger.puts ""
    @target_begin = false
  end

  def expect_none(cond = nil, args = {})
    Logger.warn "WARN  'expect' with no previous 'target'" unless @target_begin
    Logger.puts "      alter       #{result.alterations}" unless result.alterations.empty?
    Logger.puts "      expect_none #{cond} (#{cond.class})"
    Logger.puts ""
    @target_begin = false
  end

  def expect_nothing
    expect_none nil, {}
  end

  def expect_ok
    expect_exit 0
  end

  def expect_one(cond)
    Logger.warn "WARN  'expect' with no previous 'target'" unless @target_begin
    Logger.puts "      alter       #{result.alterations}" unless result.alterations.empty?
    Logger.puts "      expect_one  #{cond} (#{cond.class})"
    Logger.puts ""
    @target_begin = false
  end

  def expect_sequence(&block)
    Logger.warn "WARN  'expect' with no previous 'target'" unless @target_begin
    seq = CheckDSL::ExpectSequence.new
    seq.is_valid?(&block)
    Logger.puts "      expect_sequence #{seq.expected}"
    Logger.puts ""
    @target_begin = false
  end
end
