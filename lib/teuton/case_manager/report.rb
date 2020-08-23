require 'rainbow'
##
# Class CaseManager
# Methods related with report
class CaseManager

  private

  ##
  # Open main report (resume report)
  # @param config_filepath (String)
  def open_main_report(config_filepath)
    app = Application.instance

    @report.head[:tt_title] = "Executing [#{app.name}] (version #{Application::VERSION})"
    @report.head[:tt_scriptname] = trim(app.script_path)
    @report.head[:tt_configfile] = trim(config_filepath)
    @report.head[:tt_pwd] = app.running_basedir
    @report.head[:tt_debug] = true if @debug
    # @report.head[:tt_uses] = app.uses.join(', ') # TO-REVISE
    @report.head.merge!(app.global)

    verboseln ' '
    verboseln '=' * @report.head[:tt_title].length
    verboseln Rainbow(@report.head[:tt_title]).yellow.bright
  end

  def close_main_report(start_time)
    finish_time = Time.now
    @report.tail[:start_time] = start_time
    @report.tail[:finish_time] = finish_time
    @report.tail[:duration] = finish_time - start_time

    verbose Rainbow("\n[INFO] Duration = #{format('%3.3f',(finish_time - start_time))}").yellow.bright
    verboseln Rainbow("    (#{finish_time})").yellow.bright
    verboseln '=' * @report.head[:tt_title].length
    verboseln ' '

    app = Application.instance
    @cases.each do |c|
      line = {}
      if c.skip?
        line = { skip: true, id: '-', grade: 0.0, letter: '',
                members: '-', conn_status: {},
                moodle_id: '', moodle_feedback: '' }
      else
        line[:skip] = false
        line[:id] = format('%<id>02d', { id: c.id.to_i })
        line[:letter] = app.letter[:error] if c.grade < 50.0
        line[:grade] = c.grade.to_f #format('  %3d', c.grade.to_f)
        line[:members] = c.members
        line[:conn_status] = c.conn_status
        line[:moodle_id] = c.get(:tt_moodle_id)
        line[:moodle_feedback] = "\"Filename: #{c.filename}. Date: #{Time.now}\""
      end
      @report.lines << line
    end
  end

  ##
  # Trim string text when is too long
  # @param input (String)
  # @return String
  def trim(input)
    return input unless input.to_s.start_with? Dir.pwd.to_s
    return input if input == Dir.pwd.to_s

    output = input.to_s
    offset = (Dir.pwd).length + 1
    output = "#{input[offset, input.size]}"
    output.to_s
  end
end
