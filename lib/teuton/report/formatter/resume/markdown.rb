require_relative "array"

class ResumeMarkdownFormatter < ResumeArrayFormatter
  MIN_HALL_OF_FAME = 3

  def initialize(report)
    super(report)
    @ext = "md"
    @data = {}
  end

  def process(options = {})
    build_data(options)
    process_config
    process_cases
    process_conn_errors
    process_results
    process_hof
    deinit
  end

  private

  def process_config
    w "# CONFIGURATION\n\n"
    w "| Param | Value |\n"
    w "| ----- | ----- |\n"
    @data[:config].each { |key, value| w("| #{key} | #{trim(value)} |\n") }
    w "\n"
  end

  def process_cases
    w "# CASES\n\n"
    w "| CASE | MEMBERS | GRADE | STATE |\n"
    w "| ---- | ------- | ----- | ----- |\n"
    @data[:cases].each do |line|
      grade = format("  %<grade>3d", {grade: line[:grade]})
      w "| #{line[:id]} | #{line[:members]} | #{grade} | #{line[:letter]} |\n"
    end
    w "\n"
  end

  def process_conn_errors
    lines = []
    lines << "# CONN ERRORS"
    lines << ""
    lines << "| CASE | MEMBERS | HOST | ERROR |"
    lines << "| ---- | ------- | ---- | ----- |"
    @data[:cases].each do |line|
      line[:conn_status].each_pair do |h, e|
        lines << "| #{line[:id]} | #{line[:members]} | #{h} | #{e} |\n"
      end
    end

    if lines.size > 4
      w lines.join("\n")
      w "\n\n"
    end
  end

  def process_results
    w "# RESULTS\n\n"
    w "| Param | Value |\n"
    w "| ----- | ----- |\n"
    @data[:results].each { |key, value| w("| #{key} | #{value} |\n") }
    w "\n"
  end

  def process_hof
    return if @data[:hall_of_fame].size < MIN_HALL_OF_FAME

    w "# HALL OF FAME\n\n"
    w "| Grade | Amount |\n"
    w "| ----- | ------ |\n"
    @data[:hall_of_fame].each do |grade, amount|
      if line[0] == @data[:results][:grade]
        w " | **#{grade}** | **#{amount}** |\n"
      else
        w " | #{grade} | #{amount} |\n"
      end
    end
    w "\n"
  end
end