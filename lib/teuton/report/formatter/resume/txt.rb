require "terminal-table"
require "rainbow"
require_relative "array"

class ResumeTXTFormatter < ResumeArrayFormatter
  MIN_HALL_OF_FAME = 3

  def initialize(report, colorize = false)
    @colorize = colorize
    super(report)
    @ext = "txt"
    @data = {}
  end

  def process(options = {})
    build_data(options)
    process_config
    process_cases
    process_conn_errors
    process_results
    process_hof
    deinit
  end

  private

  def process_config
    w "#{colorize("CONFIGURATION", :bg_blue)}\n"
    my_screen_table = Terminal::Table.new do |st|
      @data[:config].each do |key, value|
        st.add_row [key.to_s, trim(value)]
      end
    end
    w "#{my_screen_table}\n\n"
  end

  def process_cases
    w "#{colorize("CASES", :bg_blue)}\n"
    my_screen_table = Terminal::Table.new do |st|
      st.add_row %w[CASE MEMBERS GRADE STATE]
      @data[:cases].each do |line|
        st.add_row [
          line[:id],
          line[:members],
          format("  %<grade>3d", {grade: line[:grade]}),
          line[:letter]
        ]
      end
    end
    w "#{my_screen_table}\n\n"
  end

  def process_conn_errors
    my_screen_table = Terminal::Table.new do |st|
      st.add_row %w[CASE MEMBERS HOST ERROR]
      @data[:cases].each do |line|
        line[:conn_status].each_pair do |h, e|
          st.add_row [line[:id], line[:members], h, e]
        end
      end
    end
    return unless my_screen_table.rows.size > 1

    w "#{colorize("CONN ERRORS", :bg_red)}\n#{my_screen_table}\n\n"
  end

  def process_results
    w "#{colorize("RESULTS", :bg_blue)}\n"
    my_screen_table = Terminal::Table.new do |st|
      @data[:results].each do |key, value|
        st.add_row [key.to_s, value.to_s]
      end
    end
    w "#{my_screen_table}\n\n"
  end

  def process_hof
    return if @data[:hall_of_fame].size < MIN_HALL_OF_FAME

    w "#{colorize("HALL OF FAME", :bg_blue)}\n"
    my_screen_table = Terminal::Table.new do |st|
      @data[:hall_of_fame].each do |line|
        color = :green
        color = :red if line[0] < 50
        text1 = colorize(line[0], color)
        text2 = colorize(line[1], color)
        if line[0] == @data[:results][:grade]
          text1 = colorize(text1, :bright)
          text2 = colorize(text2, :bright)
        end
        st.add_row [text1, text2]
      end
    end
    w "#{my_screen_table}\n"
  end

  def colorize(text, option)
    return text unless @colorize

    case option
    when :bg_blue
      Rainbow(text).bg(:blue)
    when :blue_bright
      Rainbow(text).blue.bright
    when :bright
      Rainbow(text).bright
    when :green
      Rainbow(text).color(:green)
    when :red
      Rainbow(text).color(:red)
    else
      puts "[ERROR] ResumeTXTFormatter#colorize option=#{option}"
      exit 1
    end
  end
end
