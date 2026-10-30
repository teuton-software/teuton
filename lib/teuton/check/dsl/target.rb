module CheckDSL
  def target(desc, args = {})
    Logger.warn "Previous 'target' requires 'expect'" if @target_begin
    @target_begin = true
    @stats[:targets] += 1
    @targetid += 1
    weight = args[:weight] ? args[:weight].to_f : 1.0
    Logger.puts ""
    Logger.puts format("(%03<targetid>d) target      %<desc>s", targetid: @targetid, desc: desc)
    Logger.puts "      weight      #{weight}"
  end

  def goal(...)
    Logger.warn("Keyword deprecated: Replace 'goal' by 'target'.")
    target(...)
  end
end
