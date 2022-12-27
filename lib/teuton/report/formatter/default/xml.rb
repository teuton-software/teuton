require_relative "../base_formatter"
require_relative "../../../version"

class XMLFormatter < BaseFormatter
  def initialize(report)
    super(report)
    @ext = "xml"
  end

  def process
    tab = "  "
    w "<teuton version='#{Teuton::VERSION}'>\n"
    w "#{tab}<head>\n"
    @head.each { |key, value| w "#{tab * 2}<#{key}>#{value}</#{key}>\n" }
    w "#{tab}</head>\n"
    w "#{tab}<lines>\n"
    @lines.each do |i|
      unless i.instance_of? Hash
        w "#{tab * 2}<line type='log'>#{i}</line>\n"
        next
      end
      w "#{tab * 2}<line>\n"
      w "#{tab * 3}<id>#{i[:id]}</id>\n"
      w "#{tab * 3}<description>#{i[:description]}</description>\n"
      w "#{tab * 3}<command"
      w " tempfile='#{i[:tempfile]}'" if i[:tempfile]
      w ">#{i[:command]}</command>\n"
      w "#{tab * 3}<check>#{i[:check]}</check>\n"
      w "#{tab * 3}<weigth>#{i[:weight]}</weigth>\n"
      w "#{tab * 2}</line>\n"
    end
    w "#{tab}</lines>\n"
    w "#{tab}<tail>\n"
    @tail.each { |key, value| w "#{tab * 2}<#{key}>#{value}</#{key}>\n" }
    w "#{tab}</tail>\n"
    w "</teuton>\n"

    deinit
  end
end
