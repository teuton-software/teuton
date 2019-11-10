# frozen_string_literal: true

require_relative 'base_formatter'

# ArrayFormatter class: format report data into an array
class ResumeArrayFormatter < BaseFormatter
  def initialize(report)
    super(report)
    @data = {}
  end

  def process
    build_data
    w @data.to_s # Write data into ouput file
    deinit
  end

  def build_data
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
    app = Application.instance
    fame = {}
    if app.options[:case_number] > 2
      app.hall_of_fame.each { |line| fame[line[0]] = line[1] }
    end
    @data[:hall_of_fame] = fame
  end
end
