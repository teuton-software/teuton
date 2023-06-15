require "terminal-table"
require "rainbow"
require_relative "array"

class TXTFormatter < ArrayFormatter
  def initialize(report, color = false)
    @color = color
    super(report)
    @ext = "txt"
    @data = {}
  end

  def process(options = {})
    rainbow_state = Rainbow.enabled
    Rainbow.enabled = @color

    build_data(options)
    process_config
    process_logs
    process_groups
    process_results
    process_hof
    deinit

    Rainbow.enabled = rainbow_state
  end

  private

  def process_config
    w "#{Rainbow("CONFIGURATION").bg(:blue)}\n"
    my_screen_table = Terminal::Table.new do |st|
      @data[:config].sort.each { |key, value| st.add_row [key.to_s, value.to_s] }
    end
    w "#{my_screen_table}\n\n"
  end

  def process_logs
    return if @data[:logs].size == 0

    w "#{Rainbow("LOGS").bg(:blue)}\n"
    @data[:logs].each { |line| w "    #{line}\n" }
  end

  def process_groups
    return if @data[:groups].size == 0

    w "\n#{Rainbow("GROUPS").bg(:blue)}\n"
    @data[:groups].each { |g| process_group g }
  end

  def process_results
    w "\n#{Rainbow("RESULTS").bg(:blue)}\n"
    my_screen_table = Terminal::Table.new do |st|
      @data[:results].each do |key, value|
        st.add_row [key.to_s, value.to_s]
      end
    end
    w "#{my_screen_table}\n"
  end

  def process_hof
    return if @data[:hall_of_fame].size < 3

    w "\n#{Rainbow("HALL OF FAME").bg(:blue)}\n"
    my_screen_table = Terminal::Table.new do |st|
      @data[:hall_of_fame].each do |line|
        mycolor = :green
        mycolor = :red if line[0] < 50
        text1 = Rainbow(line[0]).color(mycolor)
        text2 = Rainbow(line[1]).color(mycolor)
        if line[0] == @data[:results][:grade]
          text1 = text1.bright
          text2 = text2.bright
        end
        st.add_row [text1, text2]
      end
    end
    w "#{my_screen_table}\n"
  end

  private

  def process_group(group)
    tab = "  "
    w "- #{Rainbow(group[:title]).blue.bright}\n"
    group[:targets].each do |i|
      color = :red
      color = :green if i[:check]
      w tab * 2 + format("%02d", i[:target_id].to_i)
      w " (" + Rainbow(i[:score].to_s + "/" + i[:weight].to_s).color(color) + ")\n"
      w "#{tab * 4}Description : #{i[:description]}\n"
      w "#{tab * 4}Command     : #{i[:command]}\n"
      w "#{tab * 4}Output      : #{i[:output]}\n"
      w "#{tab * 4}Duration    : #{i[:duration]} (#{i[:conn_type]})\n"
      w "#{tab * 4}Alterations : #{i[:alterations]}\n"
      w "#{tab * 4}Expected    : #{i[:expected]}\n"
      w "#{tab * 4}Result      : #{i[:result]}\n"
    end
  end
end
