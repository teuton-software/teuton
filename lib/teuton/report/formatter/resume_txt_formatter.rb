# frozen_string_literal: true

require 'terminal-table'
require 'rainbow'
require_relative 'resume_array_formatter'

# TXTFormatter class
class ResumeTXTFormatter < ResumeArrayFormatter
  def initialize(report, color = false)
    @color = color
    super(report)
    @data = {}
  end

  def process
    rainbow_state = Rainbow.enabled
    Rainbow.enabled = @color

    build_data
    process_config
    process_cases
    process_conn_errors
    process_results
    process_hof
    deinit

    Rainbow.enabled = rainbow_state
  end

  private

  def process_config
    w "#{Rainbow('CONFIGURATION').bg(:blue)}\n"
    my_screen_table = Terminal::Table.new do |st|
      @data[:config].each do |key, value|
        st.add_row [key.to_s, trim(value)]
      end
    end
    w "#{my_screen_table}\n\n"
  end

  # rubocop:disable Metrics/MethodLength
  def process_cases
    w "#{Rainbow('CASES').bg(:blue)}\n"
    my_screen_table = Terminal::Table.new do |st|
      st.add_row %w[CASE MEMBERS GRADE STATE]
      @data[:cases].each do |line|
        st.add_row [line[:id],
                    line[:members],
                    format('  %<grade>3d', { grade: line[:grade] }),
                    line[:letter]]
      end
    end
    w "#{my_screen_table}\n\n"
  end
  # rubocop:enable Metrics/MethodLength

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

    w "#{Rainbow('CONN ERRORS').bg(:red)}\n#{my_screen_table}\n"
  end

  def process_results
    w "\n#{Rainbow('RESULTS').bg(:blue)}\n"
    my_screen_table = Terminal::Table.new do |st|
      @data[:results].each do |key, value|
        st.add_row [key.to_s, value.to_s]
      end
    end
    w "#{my_screen_table}\n"
  end

  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Metrics/AbcSize
  def process_hof
    return if @data[:hall_of_fame].size < 3

    w "\n#{Rainbow('HALL OF FAME').bg(:blue)}\n"
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
  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Metrics/AbcSize
end
