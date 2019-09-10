# frozen_string_literal: true

require_relative 'resume_array_formatter'

# MoodleCSVFormatter class
class MoodleCSVFormatter < ResumeArrayFormatter
  def initialize(report)
    super(report)
    @data = {}
  end

  def process
    build_data
    process_cases
    deinit
  end

  private

  def process_cases
    # MoodleID, Grade, Feedback
    w "MoodleID, TeutonGrade, TeutonFeedback\n"
    @data[:cases].each do |line|
      w "#{line[:moodle_id]},#{line[:grade]},#{line[:moodle_feedback]}\n"
    end
  end
end
