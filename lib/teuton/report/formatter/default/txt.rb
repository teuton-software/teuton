require "terminal-table"
require "rainbow"
require_relative "array"

class TXTFormatter < ArrayFormatter
  def initialize(report, colorize = false)
    @colorize = colorize
    super(report)
    @ext = "txt"
    @data = {}
  end

  def process(options = {})
    build_data(options)
    process_config
    process_logs
    process_groups
    process_results
    process_hof
    deinit
  end

  private

  def process_config
    w "#{colorize(" \u{2692} CONFIGURATION", :bg_blue)}\n"
    table = Terminal::Table.new do |t|
      t.style = { border: :unicode }
      @data[:config].sort.each { |key, value| t.add_row [key.to_s, value.to_s] }
    end
    w "#{table}\n"
  end

  def process_logs
    return if @data[:logs].empty?

    w "#{colorize("\n \u{1f6c8} LOGS", :bg_blue)}\n"
    @data[:logs].each { |line| w "   #{line}\n" }
  end

  def process_groups
    return if @data[:groups].empty?

    w "\n#{colorize(" \u{1f46a} GROUPS", :bg_blue)}\n"
    @data[:groups].each { |g| process_group g }
  end

  def process_results
    w "\n#{colorize(" \u{1f5f9} RESULTS", :bg_blue)}\n"
    table = Terminal::Table.new do |t|
      t.style = { border: :unicode }
      @data[:results].each { |key, value| t.add_row [key.to_s, value.to_s] }
    end
    w "#{table}\n"
  end

  def process_hof
    return if @data[:hall_of_fame].empty?

    w "\n#{colorize(" \u{2605} HALL OF FAME", :bg_blue)}\n"
    my_screen_table = Terminal::Table.new do |t|
      t.style = { border: :unicode }
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
    w "#{my_screen_table}\n"
  end

  private

  def process_group(group)
    tab = "  "
    w " \u{25B6} #{colorize(group[:title], :blue_bright)}\n"
    corner = nil
    group[:targets].each do |i|
      if i[:check]
        color = :green
        symbol = Settings.letter[:ok]
      else
        color = :red
        symbol = Settings.letter[:cross]
      end
      w tab * 1 + format(" #{symbol} %02d", i[:target_id].to_i)
      text = "#{i[:score]}/#{i[:weight]}"
      corner = if corner.nil?
                 "┌──"
               else
                 "├──"
               end
      s = " " * (10 - text.size)
      w " (#{colorize(text, color)})#{s}#{corner}\n"
      w "#{tab * 4}Description │ #{i[:description]}\n"
      w "#{tab * 4}Command     │ #{i[:command]}\n"
      w "#{tab * 4}Output      │ #{i[:output]}\n"
      w "#{tab * 4}Duration    │ #{i[:duration]} (#{i[:conn_type]})\n"
      w "#{tab * 4}Alterations │ #{i[:alterations]}\n"
      w "#{tab * 4}Expected    │ #{i[:expected]}\n"
      w "#{tab * 4}Result      │ #{i[:result]}\n"
    end
    w "#{tab * 10}└──"
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
      Logger.warn "[TXTFormatter] colorize option=#{option}"
      text
    end
  end
end
