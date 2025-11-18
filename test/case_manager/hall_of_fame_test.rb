require "test/unit"
require_relative "../../lib/teuton/case_manager/ext/hall_of_fame"
require_relative "../../lib/teuton/utils/project"

class HallOfFameTest < Test::Unit::TestCase
  class CaseMock
    attr_reader :grade

    def initialize(grade)
      @grade = grade
    end

    def skip
      false
    end
  end

  def test_3_cases_1_grade
    cases = []
    cases << CaseMock.new(60)
    cases << CaseMock.new(60)
    cases << CaseMock.new(60)

    CheckCasesExtension::HallOfFame.new(cases).call
    assert_equal 3, Project.value[:options][:case_number]
    assert_equal true, Project.value[:hall_of_fame].empty?
  end

  def test_3_cases_2_grades
    cases = []
    cases << CaseMock.new(60)
    cases << CaseMock.new(60)
    cases << CaseMock.new(90)

    CheckCasesExtension::HallOfFame.new(cases).call
    assert_equal 3, Project.value[:options][:case_number]
    assert_equal true, Project.value[:hall_of_fame].empty?
  end

  def test_3_cases_3_grades
    cases = []
    cases << CaseMock.new(30)
    cases << CaseMock.new(60)
    cases << CaseMock.new(90)

    CheckCasesExtension::HallOfFame.new(cases).call
    assert_equal 3, Project.value[:options][:case_number]
    assert_equal [90, "*"], Project.value[:hall_of_fame][0]
    assert_equal [60, "*"], Project.value[:hall_of_fame][1]
    assert_equal [30, "*"], Project.value[:hall_of_fame][2]
  end

  def test_5_cases_3_grades
    cases = []
    cases << CaseMock.new(30)
    cases << CaseMock.new(60)
    cases << CaseMock.new(60)
    cases << CaseMock.new(60)
    cases << CaseMock.new(90)

    CheckCasesExtension::HallOfFame.new(cases).call
    assert_equal 5, Project.value[:options][:case_number]
    assert_equal [90, "*"], Project.value[:hall_of_fame][0]
    assert_equal [60, "***"], Project.value[:hall_of_fame][1]
    assert_equal [30, "*"], Project.value[:hall_of_fame][2]
  end
end
