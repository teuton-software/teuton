require_relative "../../utils/project"

module CheckCasesExtension
  class HallOfFame
    MIN_HALL_OF_FAME = 3

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

      sorted_list = celebrities.sort_by { |key, _value| key }
      Project.value[:hall_of_fame] = (sorted_list.size < MIN_HALL_OF_FAME) ? [] : sorted_list.reverse
    end
  end
end
