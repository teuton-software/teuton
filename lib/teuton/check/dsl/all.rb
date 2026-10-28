require_relative "builtin"
require_relative "expect"
require_relative "event"
require_relative "getset"
require_relative "run"
require_relative "target"

module CheckDSL
  def log(text = "", type = :info)
    @stats[:logs] += 1
    prefix = (type == :info) ? "" : "#{type.to_s.upcase}: "
    Logger.puts "      log         #{prefix}" + text.to_s
  end

  def doc(text)
    @stats[:readmes] += 1
    Logger.puts "      doc         #{text}"
  end

  def readme(...)
    Logger.warn("Keyword deprecated: Replace 'readme' by 'doc'.")
    doc(...)
  end

  def unique(key, _value)
    @stats[:uniques] += 1

    Logger.puts "      unique      value for <#{key}>"
    Logger.puts ""
  end
end
