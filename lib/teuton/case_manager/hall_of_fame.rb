
require_relative '../application'

class CaseManager

  private

  def build_hall_of_fame
    celebrities = {}

    @cases.each do |c|
      grade = c.grade # report.tail[:grade]
      if celebrities[grade]
        label = celebrities[grade] + '*'
      else
        label = '*'
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
