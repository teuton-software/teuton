
class CaseManager

  private

  def open_main_report(p_config_filename)
    app = Application.instance

    @report.head[:tt_title] = "Executing [#{app.name}] (version #{app.version})"
    @report.head[:tt_scriptname] = app.script_path
    @report.head[:tt_configfile] = p_config_filename
    @report.head[:tt_debug] = true if @debug
    @report.head.merge!(app.global)

    my_execute('clear')
    verboseln '=' * @report.head[:tt_title].length
    verboseln @report.head[:tt_title]
  end

  def close_main_report(start_time)
    finish_time = Time.now
    @report.tail[:start_time] = start_time
    @report.tail[:finish_time] = finish_time
    @report.tail[:duration] = finish_time - start_time

    verboseln "\n[INFO] Duration = #{(finish_time - start_time)} (#{finish_time})"
    verboseln "\n"
    verboseln '=' * @report.head[:tt_title].length

    app = Application.instance
    @cases.each do |c|
      l_members = c.report.head[:tt_members] || 'noname'
      l_grade = c.report.tail[:grade] || 0.0
      l_help = app.letter[:none]
      l_help = app.letter[:error] if l_grade < 50.0
      # t = 'Case_' + "%02d" % c.id.to_i + ' => '
      t = format('Case_%02d => ', c.id.to_i)
      # t = t + "%3d" % l_grade.to_f + " #{l_help} #{l_members}"
      t += format('%3d %s %s', l_grade.to_f, l_help, l_members)
      @report.lines << t
    end
  end
end
