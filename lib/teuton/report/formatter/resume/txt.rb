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
    w "#{colorize(" \u{2692} CONFIGURATION ", :bg_blue)}\n"
    table = Terminal::Table.new do |t|
      t.style = {border: :unicode}
      @data[:config].each { |key, value| t.add_row [key.to_s, trim(value)] }
    end
    w "#{table}\n\n"
  end

  def process_cases
    w "#{colorize(" \u{1f46a} CASES", :bg_blue)}\n"
    table = Terminal::Table.new do |t|
      t.style = {border: :unicode}
      t.add_row %w[CASE MEMBERS GRADE STATE]
      @data[:cases].each do |line|
        t.add_row [
          line[:id],
          line[:members],
          format("  %<grade>3d", {grade: line[:grade]}),
          line[:letter]
        ]
      end
    end
    w "#{table}\n\n"
  end

  def process_conn_errors
    table = Terminal::Table.new do |t|
      t.style = {border: :unicode}
      t.add_row %w[CASE MEMBERS HOST ERROR]
      @data[:cases].each do |line|
        line[:conn_status].each_pair do |h, e|
          t.add_row [line[:id], line[:members], h, colorize(e, :red_bright)]
        end
      end
    end
    return unless table.rows.size > 1

    w "#{colorize(" \u{1f5f2} CONN ERRORS", :bg_blue)}\n#{table}\n\n"
  end

  def process_results
    w "#{colorize(" \u{1f5f9} RESULTS", :bg_blue)}\n"
    table = Terminal::Table.new do |t|
      t.style = {border: :unicode}
      @data[:results].each { |key, value| t.add_row([key.to_s, value.to_s]) }
    end
    w "#{table}\n\n"
  end

  def process_hof
    return if @data[:hall_of_fame].size < MIN_HALL_OF_FAME

    w "#{colorize(' \u{2605} HALL OF FAME', :bg_blue)}\n"
    table = Terminal::Table.new do |t|
      t.style = {border: :unicode}
      @data[:hall_of_fame].each do |line|
        color = :green
        color = :red if line[0] < 50
        text1 = colorize(line[0], color)
        text2 = colorize(line[1], color)
        if line[0] == @data[:results][:grade]
          text1 = colorize(text1, :bright)
          text2 = colorize(text2, :bright)
        end
        t.add_row [text1, text2]
      end
    end
    w "#{table}\n"
  end

  def colorize(text, option)
    return text unless @colorize

    case option
    when :bg_blue
      Rainbow(text).bg(:blue)
    when :bg_red
      Rainbow(text).bg(:red)
    when :blue_bright
      Rainbow(text).blue.bright
    when :bright
      Rainbow(text).bright
    when :green
      Rainbow(text).color(:green)
    when :red
      Rainbow(text).color(:red)
    when :red_bright
      Rainbow(text).red.bright
    else
      Logger.warn "[ResumeTXTFormatter] colorize option=#{option}"
      text
    end
  end
end
