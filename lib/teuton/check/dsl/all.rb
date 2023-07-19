require_relative "expect"
require_relative "getset"
require_relative "run"

module CheckDSL
  def log(text = "", type = :info)
    @stats[:logs] += 1
    verboseln "      log    [#{type}]: " + text.to_s
  end

  def readme(_text)
    # Usefull for "teuton readme" command action.
  end

  def target(desc, args = {})
    if @target_begin
      puts Rainbow("WARN  Previous 'target' requires 'expect'").bright.yellow
    end
    @target_begin = true
    @stats[:targets] += 1
    @targetid += 1
    weight = args[:weight] || 1.0
    verboseln format("(%03<targetid>d) target      %<desc>s", targetid: @targetid, desc: desc)
    verboseln "      weight      #{weight}"
  end
  alias_method :goal, :target

  def unique(key, _value)
    @stats[:uniques] += 1

    verboseln "    ! Unique      value for <#{key}>"
    verboseln ""
  end
end
