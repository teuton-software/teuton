# frozen_string_literal: true

require 'terminal-table'
require_relative 'array_formatter'

# TXTFormatter class
class TXTFormatter < ArrayFormatter
  def initialize(report)
    super(report)
    @data = {}
  end

  def process
    build_data
    process_config
    process_test
    process_results
    process_hof
    deinit
  end

  private

  def process_config
    w "CONFIGURATIONS\n"
    my_screen_table = Terminal::Table.new do |st|
      @data[:config].each { |key,value| st.add_row [ key.to_s, value.to_s] }
    end
    w my_screen_table.to_s+"\n\n"
  end

  def process_test
    tab = '  '
    tab = '' if @data[:test][:logs].count == 1

    w "LOGS\n"
    @data[:test][:logs].each do |line|
      w tab + line + "\n"
    end

    if @data[:test][:groups].count > 0
      w "\nGROUPS\n"
      @data[:test][:groups].each { |g| process_group g }
    end
  end

  def process_group(group)
    tab = '  '
    w tab + group[:title] + "\n"
    group[:targets].each do |i|
      value = 0.0
      value = i[:weight] if i[:check]
      w tab*2+format("%02d", i[:target_id])+" ("+value.to_s+"/"+i[:weight].to_s+")\n"
      w tab*4+"Description : #{i[:description].to_s}\n"
      w tab*4+"Command     : #{i[:command].to_s}\n"
			w tab*4+"Duration    : #{i[:duration].to_s} (#{i[:conn_type].to_s})\n"
      w tab*4+"Alterations : #{i[:alterations].to_s}\n"
      w tab*4+"Expected    : #{i[:expected].to_s} (#{i[:expected].class.to_s})\n"
      w tab*4+"Result      : #{i[:result].to_s} (#{i[:result].class.to_s})\n"
    end
  end

  def process_results
    w "\nRESULTS\n"
    my_screen_table = Terminal::Table.new do |st|
      @data[:results].each do |key,value|
        st.add_row [ key.to_s, value.to_s]
      end
    end
    w my_screen_table.to_s+"\n"
  end

  def process_hof
    w "\nHALL OF FAME\n"
    my_screen_table = Terminal::Table.new do |st|
      @data[:hall_of_fame].each do |line|
        st.add_row [ line[0], line[1]]
      end
    end
    w my_screen_table.to_s + "\n"

    deinit
  end

end
