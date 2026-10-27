require_relative "builtin"
require_relative "expect"
require_relative "event"
require_relative "getset"
require_relative "run"

module CheckDSL
  def log(text = "", type = :info)
    @stats[:logs] += 1
    prefix = (type == :info) ? "" : "#{type.to_s.upcase}: "
    Logger.puts "      log         #{prefix}" + text.to_s
  end

  def readme(text)
    @stats[:readmes] += 1
    Logger.puts "      doc         #{text}"
  end

  def target(desc, args = {})
    Logger.warn "WARN  Previous 'target' requires 'expect'" if @target_begin
    @target_begin = true
    @stats[:targets] += 1
    @targetid += 1
    weight = args[:weight] ? args[:weight].to_f : 1.0
    Logger.puts format("(%03<targetid>d) target      %<desc>s", targetid: @targetid, desc: desc)
    Logger.puts "      weight      #{weight}"
  end

  def goal(...)
    Logger.warn("Keyword deprecated: Replace 'goal' by 'target'.")
    target(...)
  end

  def unique(key, _value)
    @stats[:uniques] += 1

    Logger.puts "      unique      value for <#{key}>"
    Logger.puts ""
  end
end
