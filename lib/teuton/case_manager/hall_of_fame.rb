require_relative "../utils/application"

class CaseManager
  class HallOfFame
    def initialize(cases)
      @cases = cases
    end

    def call
      celebrities = {}

      @cases.each do |c|
        grade = c.grade # report.tail[:grade]
        label = if celebrities[grade]
          celebrities[grade] + "*"
        else
          "*"
        end
        celebrities[grade] = label unless c.skip
      end

      a = celebrities.sort_by { |key, _value| key }
      list = a.reverse

      app = Application.instance
      app.options[:case_number] = @cases.size
      app.hall_of_fame = list
    end
  end
end
