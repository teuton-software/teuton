require_relative "resume/array"

class MoodleCSVFormatter < ResumeArrayFormatter
  def initialize(report)
    super(report)
    @ext = "csv"
    @data = {}
  end

  def process(options = {})
    build_data(options)
    process_cases
    deinit
  end

  private

  def process_cases
    max = @data[:config][:tt_moodle_max_score] || 100.0
    grade_adjust = max.to_f / 100.0
    # MoodleID, Grade, Feedback
    w "MoodleID, TeutonGrade, TeutonFeedback\n"
    @data[:cases].each do |line|
      moodle_id = line[:moodle_id]
      moodle_id = line[:moodle_id].split(",") if moodle_id.instance_of? String
      moodle_id.each do |id|
        unless line[:skip]
          grade = line[:grade].to_f * grade_adjust
          w "#{id.strip},#{grade},#{line[:moodle_feedback]}\n"
        end
      end
    end
  end
end
