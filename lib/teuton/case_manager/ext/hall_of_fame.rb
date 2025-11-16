require_relative "../../utils/project"

module CheckCasesExtension
  class HallOfFame
    def initialize(cases)
      @cases = cases
    end

    def call
      celebrities = {}

      @cases.each do |acase|
        next if acase.skip

        grade = acase.grade
        celebrities[grade] = "" if celebrities[grade].nil?
        celebrities[grade] += "*"
      end

      Project.value[:options][:case_number] = @cases.size
      ordered_list = celebrities.sort_by { |key, _value| key }
      Project.value[:hall_of_fame] = ordered_list.reverse
    end
  end
end
