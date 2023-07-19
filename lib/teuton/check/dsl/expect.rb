module CheckDSL
  def expect(cond)
    unless @target_begin
      puts Rainbow("WARN  'expect' with no previous 'target'").bright.yellow
    end
    verboseln "      alter       #{result.alterations}" unless result.alterations.empty?
    verboseln "      expect      #{cond} (#{cond.class})"
    verboseln ""
    @target_begin = false
  end

  def expect_exit(cond)
    unless @target_begin
      puts Rainbow("WARN  'expect' with no previous 'target'").bright.yellow
    end
    verboseln "      expect_exit #{cond} (#{cond.class})"
    verboseln ""
    @target_begin = false
  end

  def expect_fail
    unless @target_begin
      puts Rainbow("WARN  'expect' with no previous 'target'").bright.yellow
    end
    verboseln "      expect_fail"
    verboseln ""
    @target_begin = false
  end

  def expect_first(cond)
    unless @target_begin
      puts Rainbow("WARN  'expect' with no previous 'target'").bright.yellow
    end
    verboseln "      alter        #{result.alterations}" unless result.alterations.empty?
    verboseln "      expect_first #{cond} (#{cond.class})"
    verboseln ""
    @target_begin = false
  end

  def expect_last(cond)
    unless @target_begin
      puts Rainbow("WARN  'expect' with no previous 'target'").bright.yellow
    end
    verboseln "      alter        #{result.alterations}" unless result.alterations.empty?
    verboseln "      expect_last #{cond} (#{cond.class})"
    verboseln ""
    @target_begin = false
  end

  def expect_none(cond = nil, args = {})
    unless @target_begin
      puts Rainbow("WARN  'expect' with no previous 'target'").bright.yellow
    end
    verboseln "      alter       #{result.alterations}" unless result.alterations.empty?
    verboseln "      expect_none #{cond} (#{cond.class})"
    verboseln ""
    @target_begin = false
  end

  def expect_nothing
    expect_none nil, {}
  end

  def expect_ok
    expect_exit 0
  end

  def expect_one(cond)
    unless @target_begin
      puts Rainbow("WARN  'expect' with no previous 'target'").bright.yellow
    end
    verboseln "      alter       #{result.alterations}" unless result.alterations.empty?
    verboseln "      expect_one  #{cond} (#{cond.class})"
    verboseln ""
    @target_begin = false
  end
end
