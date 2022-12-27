require_relative "resume/array"

class MoodleCSVFormatter < ResumeArrayFormatter
  def initialize(report)
    super(report)
    @ext = "csv"
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
      moodle_id = line[:moodle_id]
      moodle_id = line[:moodle_id].split(",") if moodle_id.instance_of? String
      moodle_id.each do |id|
        w "#{id.strip},#{line[:grade]},#{line[:moodle_feedback]}\n" unless line[:skip]
      end
    end
  end
end
