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

  ##
  # Display initial configurations
  def show_initial_configurations
    puts Rainbow('INITIAL CONFIGURATIONS').bright
    my_screen_table = Terminal::Table.new do |st|
      @head.each do |key, value|
        st.add_row [key.to_s, trim(value)]
      end
    end
    puts "#{my_screen_table}\n\n"
  end

  ##
  # Display resume
  def show_resume
    show_case_list
    show_conn_status
  end

  ##
  # Display case list
  def show_case_list
    puts Rainbow('CASE RESULTS').bright
    my_screen_table = Terminal::Table.new do |st|
      st.add_row %w[CASE MEMBERS GRADE STATE]
      @lines.each do |line|
        st.add_row [line[:id], line[:members], line[:grade], line[:letter]]
      end
    end
    puts "#{my_screen_table}\n\n"
  end

  ##
  # Display Connection status
  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Metrics/AbcSize
  def show_conn_status
    errors = 0
    @lines.each { |line| errors += line[:conn_status].size }
    return if errors.zero?

    puts Rainbow('CONN ERRORS').bright
    my_screen_table = Terminal::Table.new do |st|
      st.add_row %w[CASE MEMBERS HOST ERROR]
      @lines.each do |line|
        line[:conn_status].each_pair do |host, error|
          st.add_row [line[:id], line[:members], host,
                      Rainbow(error).red.bright]
        end
      end
    end
    puts "#{my_screen_table}\n\n"
  end
  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Metrics/AbcSize

  # rubocop:disable Style/FormatString
  # rubocop:disable Style/FormatStringToken
  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def show_targets_history
    tab = '  '
    puts Rainbow('CASE RESULTS').bright
    if @lines.size == 1
      puts @lines[0]
    else
      @lines.each do |i|
        if i.class.to_s == 'Hash'
          value = 0.0
          value = i[:weight] if i[:check]
          print tab + '%03d' % i[:id].to_i
          print ' (%2.1f' % value.to_f
          print '/%2.1f' % i[:weight].to_f
          puts ') %s' % i[:description].to_s
        else
          puts "#{tab}=>  #{i}"
        end
      end
    end
    puts "\n\n"
  end
  # rubocop:enable Style/FormatString
  # rubocop:enable Style/FormatStringToken
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength

  ##
  # Display final values section on screen
  def show_final_values
    puts Rainbow('FINAL VALUES').bright
    my_screen_table = Terminal::Table.new do |st|
      @tail.each do |key, value|
        st.add_row [key.to_s, value.to_s]
      end
    end
    puts "#{my_screen_table}\n\n"
  end

  ##
  # Display hall of fame section on screen
  def show_hall_of_fame
    app = Application.instance
    return if app.hall_of_fame.size < 3

    puts Rainbow('HALL OF FAME').bright
    my_screen_table = Terminal::Table.new do |st|
      app.hall_of_fame.each do |line|
        st.add_row [line[0], line[1]]
      end
    end
    puts "#{my_screen_table}\n"
  end

  ##
  # Trim absolute path values
  def trim(input)
    return input unless input.to_s.start_with? Dir.pwd.to_s
    return input if input == Dir.pwd.to_s

    offset = Dir.pwd.length + 1
    input[offset, input.size].to_s
  end
end
