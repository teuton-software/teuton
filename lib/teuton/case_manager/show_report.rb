require "rainbow"
require "terminal-table"
require_relative "../utils/project"

# | Verbosity level | Description |
# | :-------------: | ----------- |
# | 0               | No output   |
# | 1               | Default output messages |
# | 2               | Show hall of fame |
# | 3               | Show final values |
# | 4               | Show Initial values |
class ShowReport
  MIN_HALL_OF_FAME = 3

  def initialize(report)
    @report = report
  end

  def call(verbose)
    return if Project.quiet?

    show_initial_configurations if verbose > 2
    if filename.to_s.include? "resume"
      show_resume
    else
      show_targets_history
    end
    show_final_values if verbose > 1
    show_hall_of_fame if verbose > 0
  end

  private

  def filename
    @report.filename
  end

  def head
    @report.head
  end

  def lines
    @report.lines
  end

  def tail
    @report.tail
  end

  def show_initial_configurations
    puts Rainbow("INITIAL CONFIGURATIONS").bright
    my_screen_table = Terminal::Table.new do |st|
      head.each do |key, value|
        st.add_row [key.to_s, trim(value)]
      end
    end
    puts "#{my_screen_table}\n\n"
  end

  def show_resume
    show_case_list
    show_conn_status
  end

  def show_case_list
    puts Rainbow("CASE RESULTS").bright
    my_screen_table = Terminal::Table.new do |st|
      st.add_row %w[CASE MEMBERS GRADE STATE]
      lines.each do |line|
        st.add_row [line[:id], line[:members], line[:grade], line[:letter]]
      end
    end
    puts "#{my_screen_table}\n\n"
  end

  def show_conn_status
    errors = 0
    lines.each { |line| errors += line[:conn_status].size }
    return if errors.zero?

    puts Rainbow("CONN ERRORS").bright
    my_screen_table = Terminal::Table.new do |st|
      st.add_row %w[CASE MEMBERS HOST ERROR]
      lines.each do |line|
        line[:conn_status].each_pair do |host, error|
          st.add_row [line[:id], line[:members], host, Rainbow(error).red.bright]
        end
      end
    end
    puts "#{my_screen_table}\n\n"
  end

  def show_targets_history
    tab = "  "
    puts Rainbow("CASE RESULTS").bright
    if lines.size == 1
      puts lines[0]
    else
      lines.each do |i|
        if i.instance_of?(::Hash)
          value = 0.0
          value = i[:weight] if i[:check]
          print tab + format("%03d", i[:id].to_i)
          print format(" (%2.1f", value.to_f)
          print format("/%2.1f", i[:weight].to_f)
          puts format(") %s", i[:description].to_s)
        else
          puts "#{tab}=>  #{i}"
        end
      end
    end
    puts "\n\n"
  end

  def show_final_values
    puts Rainbow("FINAL VALUES").bright
    my_screen_table = Terminal::Table.new do |st|
      tail.each do |key, value|
        st.add_row [key.to_s, value.to_s]
      end
    end
    puts "#{my_screen_table}\n\n"
  end

  def show_hall_of_fame
    hall_of_fame = Project.value[:hall_of_fame]
    return if hall_of_fame.size < MIN_HALL_OF_FAME

    puts Rainbow("HALL OF FAME").bright
    my_screen_table = Terminal::Table.new do |st|
      hall_of_fame.each do |line|
        st.add_row [line[0], line[1]]
      end
    end
    puts "#{my_screen_table}\n\n"
  end

  def trim(input)
    # Trim absolute path values
    return input unless input.to_s.start_with? Dir.pwd.to_s
    return input if input == Dir.pwd.to_s

    offset = Dir.pwd.length + 1
    input[offset, input.size].to_s
  end
end
