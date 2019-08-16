
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
    verboseln "\n"
    verboseln '=' * @report.head[:tt_title].length

    app = Application.instance
    my_screen_table = Terminal::Table.new do |st|
#      st.add_row [Rainbow('CASE ID').bright,
#                  Rainbow('COMPLETED').bright,
#                  Rainbow('MEMBERS').bright]
      st.add_row ['CASE ID',
                  'COMPLETED',
                  'MEMBERS']
    end
    @cases.each do |c|
      if c.skip?
        my_screen_table.add_row ['-', '-', '-']
        next
      end
      t1 = format('case_%02d', c.id.to_i)
      if c.grade < 50.0
        help = app.letter[:error]
        # t2 = Rainbow(format('%3d%s %s', c.grade.to_f, '%', help)).red.bright
      else
        help = app.letter[:none]
        # t2 = Rainbow(format('%3d%s %s', c.grade.to_f, '%', help)).green.bright
      end
      t2 = format('%3d%s %s', c.grade.to_f, '%', help)
      t3 = format('%s', c.members)
      my_screen_table.add_row [t1, t2, t3]
    end
    @report.lines << my_screen_table.to_s + "\n"
  end
end
