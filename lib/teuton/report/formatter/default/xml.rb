require_relative "array"

class XMLFormatter < ArrayFormatter
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
    process_logs
    process_groups
    process_results
    process_hof
    w "</teuton>\n"
    deinit
  end

  private

  def process_config
    w "  <configuration>\n"
    @data[:config].sort.each do |key, value|
      w "    <#{key}>#{value}</#{key}>\n"
    end
    w "  </configuration>\n"
    w "\n"
  end

  def process_logs
    return if @data[:logs].empty?

    w "  <logs>\n"
    @data[:logs].each { |line| w "    <log>#{line}</log>\n" }
    w "  </logs>\n"
    w "\n"
  end

  def process_groups
    return if @data[:groups].empty?

    w "  <group>\n"
    @data[:groups].each { |g| process_group g }
    w "  </group>\n"
    w "\n"
  end

  def process_results
    w "  <results>\n"
    @data[:results].sort.each do |key, value|
      w "    <#{key}>#{value}</#{key}>\n"
    end
    w "  </results>\n"
    w "\n"
  end

  def process_hof
    return if @data[:hall_of_fame].empty?

    w "  <hall_of_fame>\n"
    w "| Grade | Amount |\n"
    w "| ----- | ------ |\n"
    @data[:hall_of_fame].each do |grade, amount|
      current = ""
      current = "current='true'" if grade == @data[:results][:grade]
      w "    <line #{current}>\n"
      w "      <grade>#{grade}</grade>\n"
      w "      <amount>#{amount}</amount>\n"
      w "    <line>\n"
    end
    w "  <hall_of_fame>\n"
    w "\n"
  end

  private

  def process_group(group)
    w "    <group title='#{group[:title]}'>\n"
    group[:targets].each do |i|
      w "      <target id='#{format("%02d", i[:target_id].to_i)}'>\n"
      w "        <score>#{i[:score]}</score>\n"
      w "        <weight>#{i[:weight]}</weight>\n"
      w "        <description>#{i[:description]}</description>\n"
      w "        <command>#{i[:command]}</command>\n"
      w "        <output>#{i[:output]}</output>\n"
      w "        <duration>#{i[:duration]}</duration>\n"
      w "        <conn_type>#{i[:conn_type]}</conn_type>\n"
      w "        <alterations>#{sanitize(i[:alterations])}</alterations>\n"
      w "        <expected>#{i[:expected]}</expected>\n"
      w "        <result>#{i[:result]}</result>\n"
      w "      </target>\n"
    end
    w "    </group>\n"
  end

  def sanitize(text)
    # Replace & by &amp;
    text.gsub("&", "&amp;")
  end
end
