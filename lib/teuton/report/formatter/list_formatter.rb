# frozen_string_literal: true

require_relative 'array_formatter'

# ListFormatter class
class ListFormatter < ArrayFormatter
  def initialize(report)
    super(report)
    @data = {}
  end

  def process
    build_data
    process_config
    process_logs
    process_groups
    process_results
    process_hof
    deinit
  end

  private

  def process_config
    w "CONFIGURATION\n"
    @data[:config].sort.each { |key,value| w "  * #{key} : #{value}\n" }
    w "\n\n"
  end

  def process_logs
    return if @data[:logs].size == 0

    w "\nLOGS\n"
    @data[:logs].each { |line| w "  * #{line}\n" }
  end

  def process_groups
    return if @data[:groups].size == 0

    w "\nGROUPS\n"
    @data[:groups].each { |g| process_group g }
  end

  def process_results
    w "\nRESULTS\n"
    @data[:results].each do |key,value|
      w "  * #{key.to_s} : #{value.to_s}\n"
    end
  end

  def process_hof
    return if @data[:hall_of_fame].size < 3

    w "\nHALL OF FAME\n"
    @data[:hall_of_fame].each do |line|
      w "  #{line[0]} #{line[1]}\n"
    end
  end

  private

  def process_group(group)
    tab = '  '
    w "- #{group[:title]}\n"
    group[:targets].each do |i|
      w tab*2 + "#{format("%02d", i[:target_id].to_i)}"
      w " (#{i[:score]}/#{i[:weight]}) "
      w "#{i[:description]}\n"
    end
  end
end
