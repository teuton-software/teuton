require_relative "array"

class ResumeXMLFormatter < ResumeArrayFormatter
  MIN_HALL_OF_FAME = 3

  def initialize(report)
    super
    @ext = "xml"
    @data = {}
  end

  def process(options = {})
    build_data(options)
    w "<teuton>\n"
    w "\n"
    process_config
    process_cases
    process_conn_errors
    process_results
    process_hof
    w "</teuton>\n"
    deinit
  end

  private

  def process_config
    w "  <configuration>\n"
    @data[:config].each do |key, value|
      w("    <#{key}>#{trim(value)}</#{key}>\n")
    end
    w "  </configuration>\n"
    w "\n"
  end

  def process_cases
    w "  <cases>\n"
    @data[:cases].each do |line|
      w "    <case id='#{line[:id]}'>\n"
      w "      <members>#{line[:members]}</members>\n"
      w "      <grade>#{line[:grade]}</grade>\n"
      w "      <state>#{line[:letter]}</state>\n"
      w "    </case>\n"
    end
    w "  </cases>\n"
    w "\n"
  end

  def process_conn_errors
    lines = []
    lines << "  <conn_errors>"
    @data[:cases].each do |line|
      line[:conn_status].each_pair do |host, error|
        lines << "    <conn_error>"
        lines << "      <case>#{line[:id]}</case>"
        lines << "      <members>#{line[:members]}</members>"
        lines << "      <host>#{host}</host>"
        lines << "      <error>#{error}</error>"
        lines << "    </conn_error>"
      end
    end
    lines << "  </conn_errors>"

    if lines.size > 2
      w lines.join("\n")
      w "\n"
    end
  end

  def process_results
    w "  <results>\n"
    @data[:results].each do |key, value|
      w("    <#{key}>#{value}</#{key}>\n")
    end
    w "  </results>\n"
    w "\n"
  end

  def process_hof
    return if @data[:hall_of_fame].size < MIN_HALL_OF_FAME

    w "  <hall_of_fame>\n"
    @data[:hall_of_fame].each do |grade, amount|
      w "    <line>\n"
      w "      <grade>#{grade}</grade>\n"
      w "      <amount>#{amount}</amount>\n"
      w "    </line>\n"
    end
    w "  </hall_of_fame>\n"
    w "\n"
  end
end
