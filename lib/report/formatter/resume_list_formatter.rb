# frozen_string_literal: true

require_relative 'resume_array_formatter'

# ResumeListFormatter class
class ResumeListFormatter < ResumeArrayFormatter
  def initialize(report)
    super(report)
    @data = {}
  end

  def process
    build_data
    process_config
    process_cases
    process_conn_errors
    process_results
    process_hof
    deinit
  end

  private

  def process_config
    w "CONFIGURATION\n"
    @data[:config].each do |key,value|
      w "  * #{key}: #{trim(value)}\n"
    end
  end

  def process_cases
    w "CASES\n"
    @data[:cases].each do |line|
      w "  [#{line[:id]}] #{line[:members]}   :#{format('%3d', line[:grade])}\n"
    end
  end

  def process_conn_errors
    w "CONN ERRORS\n"
    @data[:cases].each do |line|
      line[:conn_status].each_pair do |h, e|
        w "  * #{line[:id]} #{line[:members]} #{h} #{e}\n"
      end
    end
  end

  def process_results
    w "\nRESULTS\n"
    @data[:results].each do |key,value|
      w "  * #{key}: #{value}\n"
    end
  end

  def process_hof
    return if @data[:hall_of_fame].size < 3

    w "\nHALL OF FAME\n"
    @data[:hall_of_fame].each do |line|
      w " #{line[0]} : #{line[1]}\n"
    end
  end
end
