require "rainbow"

module DSL
  # type => :info, :warn or :error
  def log(text = "", type = :info)
    s = " INFO"
    s = " WARN" if type == :warn
    s = "ERROR" if type == :error
    t = Time.now
    f = format("%<hour>02d:%<min>02d:%<sec>02d", {hour: t.hour, min: t.min, sec: t.sec})
    msg = "[#{f}] #{s}| #{text}"
    msg = "[#{f}] #{text}" if s == ""

    colored_msg = msg
    colored_msg = Rainbow(msg).yellow.bright if type == :warn
    colored_msg = Rainbow(msg).bg(:red) if type == :error

    @report.lines << colored_msg
  end
end
