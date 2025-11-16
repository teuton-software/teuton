require "rainbow"
require_relative "../../utils/project"
require_relative "../../utils/settings"

class CaseManager
  private

  ##
  # Open main report (resume report)
  # @param config_filepath (String)
  def open_main_report(config_filepath)
    @report.head[:tt_title] = "Teuton (#{Teuton::VERSION})"
    @report.head[:tt_scriptname] = trim(Project.value[:script_path])
    @report.head[:tt_configfile] = trim(config_filepath)
    @report.head[:tt_pwd] = Project.value[:running_basedir]
    @report.head[:tt_debug] = true if @debug
    @report.head[:tt_uses] = Project.value[:uses].join(", ")
    @report.head.merge!(Project.value[:global])
  end

  def close_main_report(start_time)
    finish_time = Time.now
    @report.tail[:start_time] = start_time
    @report.tail[:finish_time] = finish_time
    @report.tail[:duration] = finish_time - start_time

    duration = format("%3.3f", finish_time - start_time)
    verboseln Rainbow("\nFinished in #{duration} seconds").green
    verboseln Rainbow("-" * 36).green
    verboseln " "

    @cases.each do |c|
      line = {}
      if c.skip?
        line = {
          skip: true,
          id: "-",
          grade: 0.0,
          letter: Settings.letter(:skip),
          members: "-",
          conn_status: {},
          moodle_id: "",
          moodle_feedback: ""
        }
      else
        line[:skip] = false
        line[:id] = format("%<id>02d", {id: c.id.to_i})
        line[:letter] = Settings.letter[:cross] if c.grade.zero?
        line[:letter] = Settings.letter[:error] if c.grade < 50.0
        line[:letter] = Settings.letter[:ok] if c.grade.to_i == 100
        line[:grade] = c.grade.to_f
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

    offset = Dir.pwd.length + 1
    input[offset, input.size].to_s
  end
end
