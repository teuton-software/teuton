# frozen_string_literal: true

require_relative 'resume_array_formatter'

##
# Format data to Moodle CSV
class MoodleCSVFormatter < ResumeArrayFormatter
  ##
  # initialize instance
  # @param report (Report)
  def initialize(report)
    super(report)
    @data = {}
  end

  ##
  # Process internal data and generates data with format
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
      moodle_id = line[:moodle_id]
      moodle_id = line[:moodle_id].split(',') if moodle_id.class == String
      moodle_id.each do |id|
        w "#{id.strip},#{line[:grade]}," \
          "#{line[:moodle_feedback]}\n" unless line[:skip]
      end
    end
  end
end
