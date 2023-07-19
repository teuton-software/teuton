require_relative "expect_sequence"

module CheckDSL
  def expect(cond)
    unless @target_begin
      Logger.warn "WARN  'expect' with no previous 'target'"
    end
    Logger.info "      alter       #{result.alterations}" unless result.alterations.empty?
    Logger.info "      expect      #{cond} (#{cond.class})"
    Logger.info ""
    @target_begin = false
  end

  def expect_exit(cond)
    unless @target_begin
      Logger.warn "WARN  'expect' with no previous 'target'"
    end
    Logger.info "      expect_exit #{cond} (#{cond.class})"
    Logger.info ""
    @target_begin = false
  end

  def expect_fail
    unless @target_begin
      Logger.warn "WARN  'expect' with no previous 'target'"
    end
    Logger.info "      expect_fail"
    Logger.info ""
    @target_begin = false
  end

  def expect_first(cond)
    unless @target_begin
      Logger.warn "WARN  'expect' with no previous 'target'"
    end
    Logger.info "      alter        #{result.alterations}" unless result.alterations.empty?
    Logger.info "      expect_first #{cond} (#{cond.class})"
    Logger.info ""
    @target_begin = false
  end

  def expect_last(cond)
    unless @target_begin
      Logger.warn "WARN  'expect' with no previous 'target'"
    end
    Logger.info "      alter        #{result.alterations}" unless result.alterations.empty?
    Logger.info "      expect_last #{cond} (#{cond.class})"
    Logger.info ""
    @target_begin = false
  end

  def expect_none(cond = nil, args = {})
    unless @target_begin
      Logger.warn "WARN  'expect' with no previous 'target'"
    end
    Logger.info "      alter       #{result.alterations}" unless result.alterations.empty?
    Logger.info "      expect_none #{cond} (#{cond.class})"
    Logger.info ""
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
      Logger.warn "WARN  'expect' with no previous 'target'"
    end
    Logger.info "      alter       #{result.alterations}" unless result.alterations.empty?
    Logger.info "      expect_one  #{cond} (#{cond.class})"
    Logger.info ""
    @target_begin = false
  end

  def expect_sequence(&block)
    unless @target_begin
      Logger.warn "WARN  'expect' with no previous 'target'"
    end
    seq = CheckDSL::ExpectSequence.new
    seq.is_valid?(&block)
    Logger.info "      expect_sequence #{seq.expected}"
    Logger.info ""
    @target_begin = false
  end
end
