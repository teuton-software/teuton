# frozen_string_literal: true

# Show methods for Report class.
class Report
  ##
  # Display [Report] information on screen
  def show
    show_initial_configurations
    if @filename.to_s.include? 'resume'
      show_resume
    else
      show_targets_history
    end
    show_final_values
    show_hall_of_fame
  end

  private

  def show_initial_configurations
    puts 'INITIAL CONFIGURATIONS'
    my_screen_table = Terminal::Table.new do |st|
      @head.each do |key, value|
        st.add_row [key.to_s, trim(value)]
      end
    end
    puts my_screen_table.to_s + "\n\n"
  end

  def show_resume
    show_case_list
    show_conn_status
  end

  def show_case_list
    puts 'CASE RESULTS'
    my_screen_table = Terminal::Table.new do |st|
      st.add_row ['CASE', 'MEMBERS', 'GRADE', 'STATE' ]
      @lines.each do |line|
        st.add_row [line[:id], line[:members], line[:grade], line[:letter]]
      end
    end
    puts my_screen_table.to_s + "\n\n"
  end

  def show_conn_status
    e = 0
    @lines.each { |line| e += line[:conn_status].size }
    return if e == 0

    puts 'CONN ERRORS'
    my_screen_table = Terminal::Table.new do |st|
      st.add_row ['CASE', 'MEMBERS', 'HOST', 'ERROR']
      @lines.each do |line|
        line[:conn_status].each_pair do |h,e|
          st.add_row [line[:id], line[:members], h, e]
        end
      end
    end
    puts my_screen_table.to_s + "\n\n"
  end

  def show_targets_history
    tab = '  '
    puts 'CASE RESULTS'
    if @lines.size == 1
      puts @lines[0]
    else
      @lines.each do |i|
        if i.class.to_s == 'Hash'
          value = 0.0
          value = i[:weight] if i[:check]
          print tab + "%03d" % i[:id].to_i
          print ' (' + '%2d.2f' % value.to_f + '/'
          puts '%2d.2f' % i[:weight].to_f + ') ' + i[:description].to_s
        else
          puts tab + '-  ' + i.to_s
        end
      end
    end
    puts "\n\n"
  end

  def show_final_values
    puts 'FINAL VALUES'
    my_screen_table = Terminal::Table.new do |st|
      @tail.each do |key, value|
        st.add_row [key.to_s, value.to_s]
      end
    end
    puts my_screen_table.to_s + "\n\n"
  end

  def show_hall_of_fame
    app = Application.instance
    return if app.hall_of_fame.size < 3

    puts 'HALL OF FAME'
    my_screen_table = Terminal::Table.new do |st|
      app.hall_of_fame.each do |line|
        st.add_row [line[0], line[1]]
      end
    end
    puts my_screen_table.to_s + "\n"
  end

  def trim(input)
    output = input.to_s
    return output if output.size<65
    output = "...#{input[input.size-50, input.size]}"
    output.to_s
  end
end
