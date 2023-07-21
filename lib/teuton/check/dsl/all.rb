require_relative "builtin"
require_relative "expect"
require_relative "getset"
require_relative "run"

module CheckDSL
  def log(text = "", type = :info)
    @stats[:logs] += 1
    prefix = (type == :info) ? "" : "#{type.to_s.upcase}: "
    Logger.info "      log         #{prefix}" + text.to_s
  end

  def readme(text)
    @stats[:readmes] += 1

    Logger.info "      readme      #{text}"
  end

  def target(desc, args = {})
    if @target_begin
      Logger.warn "WARN  Previous 'target' requires 'expect'"
    end
    @target_begin = true
    @stats[:targets] += 1
    @targetid += 1
    weight = args[:weight] ? args[:weight].to_f : 1.0
    Logger.info format("(%03<targetid>d) target      %<desc>s", targetid: @targetid, desc: desc)
    Logger.info "      weight      #{weight}"
  end
  alias_method :goal, :target

  def unique(key, _value)
    @stats[:uniques] += 1

    Logger.info "      unique      value for <#{key}>"
    Logger.info ""
  end
end
