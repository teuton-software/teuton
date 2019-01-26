
class CaseManager

  def export(args = {})
    if args.class != Hash
      puts "[ERROR] tool#export: Argument = <#{args}>, class = #{args.class}"
      puts '        Use: export :format => :colored_text'
      raise '[ERROR] tool#export: Arguments are incorrect'
    end
    # default :mode=>:all, :format=>:txt
    format = args[:format] || :txt

    mode = args[:mode] || :all
    @report.export format if mode == :resume || mode == :all

    if mode == :details || mode == :all
      threads = []
      @cases.each { |c| threads << Thread.new { c.report.export format } }
      threads.each(&:join)
    end
  end
end
