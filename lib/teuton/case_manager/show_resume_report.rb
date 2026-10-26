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
class ShowResumeReport
  MIN_HALL_OF_FAME = 3

  def initialize(report)
    @report = report
  end

  def call(verbose)
    return if Project.quiet?

    show_initial_configurations if verbose > 2
    if @report.filename.to_s.include? "resume"
      show_resume
    else
      show_targets_history
    end
    show_final_values if verbose > 1
    show_hall_of_fame if verbose > 0
  end

  private

  def show_initial_configurations
    Logger.puts Rainbow(" INITIAL CONFIGURATIONS").bright
    table = Terminal::Table.new do |t|
      t.style = {border: :unicode}
      @report.head.each { |key, value| t.add_row [key.to_s, trim(value)] }
    end
    Logger.puts "#{table}\n\n"
  end

  def show_resume
    show_case_list
    show_conn_status
  end

  def show_case_list
    Logger.puts Rainbow(" \u{1f5f9} CASE RESULTS").bright
    table = Terminal::Table.new do |t|
      t.style = {border: :unicode}
      t.add_row %w[CASE MEMBERS GRADE STATE]
      @report.lines.each do |line|
        t.add_row [line[:id], line[:members], line[:grade], line[:letter]]
      end
    end
    Logger.puts "#{table}\n\n"
  end

  def show_conn_status
    errors = 0
    @report.lines.each { |line| errors += line[:conn_status].size }
    return if errors.zero?

    Logger.puts Rainbow(" \u{1f5f2} CONN ERRORS").bright
    table = Terminal::Table.new do |t|
      t.style = {border: :unicode}
      t.add_row %w[CASE MEMBERS HOST ERROR]
      @report.lines.each do |line|
        line[:conn_status].each_pair do |host, error|
          t.add_row [line[:id], line[:members], host, Rainbow(error).blue.bright]
        end
      end
    end
    Logger.puts "#{table}\n\n"
  end

  def show_targets_history
    tab = "  "
    Logger.puts Rainbow(" CASE RESULTS").bright
    if @report.lines.size == 1
      puts lines[0]
    else
      @report.lines.each do |i|
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
    Logger.puts "\n\n"
  end

  def show_final_values
    Logger.puts Rainbow(" FINAL VALUES").bright
    table = Terminal::Table.new do |t|
      t.style = {border: :unicode}
      @report.tail.each { |key, value| t.add_row [key.to_s, value.to_s] }
    end
    Logger.puts "#{table}\n\n"
  end

  def show_hall_of_fame
    hall_of_fame = Project.value[:hall_of_fame]
    return if hall_of_fame.size < MIN_HALL_OF_FAME

    Logger.puts Rainbow(" HALL OF FAME").bright
    table = Terminal::Table.new do |t|
      t.style = {border: :unicode}
      hall_of_fame.each { |line| t.add_row [line[0], line[1]] }
    end
    Logger.puts "#{table}\n\n"
  end

  def trim(input)
    # Trim absolute path values
    return input unless input.to_s.start_with? Dir.pwd.to_s
    return input if input == Dir.pwd.to_s

    offset = Dir.pwd.length + 1
    input[offset, input.size].to_s
  end
end
