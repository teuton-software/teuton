
class CaseManager

  private

  def open_main_report(p_config_filename)
    app = Application.instance

    @report.head[:tt_title] = "Executing [#{app.name}] (version #{app.version})"
    @report.head[:tt_scriptname] = app.script_path
    @report.head[:tt_configfile] = p_config_filename
    @report.head[:tt_debug] = true if @debug
    @report.head.merge!(app.global)

    verboseln '=' * @report.head[:tt_title].length
    verboseln @report.head[:tt_title]
  end

  def close_main_report(start_time)
    finish_time = Time.now
    @report.tail[:start_time] = start_time
    @report.tail[:finish_time] = finish_time
    @report.tail[:duration] = finish_time - start_time

    verboseln "\n[INFO] Duration = #{(finish_time - start_time)} (#{finish_time})"
    verboseln '=' * @report.head[:tt_title].length

    app = Application.instance
    @cases.each do |c|
      line = {}
      if c.skip?
        line = { id: '-', grade: '-', letter: ' ', members: '-' }
      end
      line[:id] = format('case_%02d', c.id.to_i)
      line[:letter] = app.letter[:error] if c.grade < 50.0
      line[:grade] = c.grade.to_f #format('  %3d', c.grade.to_f)
      line[:members] = c.members
      line[:moodle_id] = c.get(:tt_moodle_id)
      line[:moodle_feedback] = "\"Filename: #{c.filename}. Date: #{Time.now}\""
      @report.lines << line
    end
  end
end
