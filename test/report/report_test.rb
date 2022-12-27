require "test/unit"
require_relative "../../lib/teuton/report/report"

class ReportTest < Test::Unit::TestCase
  def test_clone
    report1 = Report.new
    report1.head = [1, 2, 3]
    report1.lines = [4, 5, 6]
    report1.tail = [7, 8, 9]

    report2 = report1.clone

    assert_equal report2.head, report1.head
    assert_equal report2.lines, report1.lines
    assert_equal report2.tail, report1.tail

    report1.head << 11
    report1.lines << 44
    report1.tail << 77

    assert_not_equal report2.head, report1.head
    assert_not_equal report2.lines, report1.lines
    assert_not_equal report2.tail, report1.tail
  end
end
