require_relative "../base_formatter"
require_relative "../../../utils/project"

class ResumeArrayFormatter < BaseFormatter
  def initialize(report)
    super
    @data = {}
  end

  def process(options = {})
    build_data(options)
    w @data.to_s # Write data into ouput file
    deinit
  end

  def build_data(options)
    build_initial_data
    build_cases_data
    build_final_data
    build_hof_data
  end

  def build_initial_data
    head = {}
    @head.each { |key, value| head[key] = value }
    @data[:config] = head
  end

  def build_cases_data
    @data[:cases] = @lines
  end

  def build_final_data
    tail = {}
    @tail.each { |key, value| tail[key] = value }
    @data[:results] = tail
  end

  def build_hof_data
    fame = {}
    if Project.value[:options][:case_number] > 2
      Project.value[:hall_of_fame].each { |line| fame[line[0]] = line[1] }
    end
    @data[:hall_of_fame] = fame
  end
end
