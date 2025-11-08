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
    w "#{colorize("CONFIGURATION", :bg_blue)}\n"
    my_screen_table = Terminal::Table.new do |st|
      @data[:config].sort.each do |key, value|
        st.add_row [key.to_s, value.to_s]
      end
    end
    w "#{my_screen_table}\n\n"
  end

  def process_logs
    return if @data[:logs].empty?

    w "#{colorize("LOGS", :bg_blue)}\n"
    @data[:logs].each { |line| w "    #{line}\n" }
  end

  def process_groups
    return if @data[:groups].empty?

    w "\n#{colorize("GROUPS", :bg_blue)}\n"
    @data[:groups].each { |g| process_group g }
  end

  def process_results
    w "\n#{colorize("RESULTS", :bg_blue)}\n"
    my_screen_table = Terminal::Table.new do |st|
      @data[:results].each do |key, value|
        st.add_row [key.to_s, value.to_s]
      end
    end
    w "#{my_screen_table}\n"
  end

  def process_hof
    return if @data[:hall_of_fame].size < 3

    w "\n#{colorize("HALL OF FAME", :bg_blue)}\n"
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

  private

  def process_group(group)
    tab = "  "
    w "- #{colorize(group[:title], :blue_bright)}\n"
    group[:targets].each do |i|
      color = :red
      color = :green if i[:check]
      w tab * 2 + format("%02d", i[:target_id].to_i)
      text = "#{i[:score]}/#{i[:weight]}"
      w " (#{colorize(text, color)})\n"
      w "#{tab * 4}Description : #{i[:description]}\n"
      w "#{tab * 4}Command     : #{i[:command]}\n"
      w "#{tab * 4}Output      : #{i[:output]}\n"
      w "#{tab * 4}Duration    : #{i[:duration]} (#{i[:conn_type]})\n"
      w "#{tab * 4}Alterations : #{i[:alterations]}\n"
      w "#{tab * 4}Expected    : #{i[:expected]}\n"
      w "#{tab * 4}Result      : #{i[:result]}\n"
    end
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
      puts option
      exit 1
    end
  end
end
