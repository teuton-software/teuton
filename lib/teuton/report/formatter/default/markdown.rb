require_relative "array"

class MarkdownFormatter < ArrayFormatter
  def initialize(report)
    super
    @ext = "md"
    @data = {}
  end

  def process(options = {})
    build_data(options)
    process_config
    process_logs
    process_groups
    process_results
    process_hof
    deinit
  end

  private

  def process_config
    w "# CONFIGURATION\n\n"
    w "| Param | Value |\n"
    w "| ----- | ----- |\n"
    @data[:config].sort.each { |key, value| w "| #{key} | #{value} |\n" }
    w "\n"
  end

  def process_logs
    return if @data[:logs].empty?

    w "# LOGS\n\n"
    @data[:logs].each { |line| w "* #{line}\n" }
    w "\n"
  end

  def process_groups
    return if @data[:groups].empty?

    w "# GROUPS\n\n"
    @data[:groups].each { |g| process_group g }
    w "\n"
  end

  def process_results
    w "# RESULTS\n\n"
    w "| Param | Value |\n"
    w "| ----- | ----- |\n"
    @data[:results].sort.each { |key, value| w "| #{key} | #{value} |\n" }
    w "\n"
  end

  def process_hof
    return if @data[:hall_of_fame].size < 3

    w "# HALL OF FAME\n\n"
    w "| Grade | Amount |\n"
    w "| ----- | ------ |\n"
    @data[:hall_of_fame].each do |grade, amount|
      if grade == @data[:results][:grade]
        w "| **#{grade}** | **#{amount}** |\n"
      else
        w "| #{grade} | #{amount} |\n"
      end
    end
    w "\n"
  end

  private

  def process_group(group)
    tab = "  "
    w "* **#{group[:title]}**\n"
    group[:targets].each do |i|
      style = "_"
      style = "" if i[:check]
      w "#{tab * 1}* #{format("%02d", i[:target_id].to_i)}"
      text = "#{i[:score]}/#{i[:weight]}"
      w " #{style}(#{text})#{style}\n"
      w "#{tab * 2} * Description : #{i[:description]}\n"
      w "#{tab * 2} * Command     : #{i[:command]}\n"
      w "#{tab * 2} * Output      : #{i[:output]}\n"
      w "#{tab * 2} * Duration    : #{i[:duration]} (#{i[:conn_type]})\n"
      w "#{tab * 2} * Alterations : #{i[:alterations]}\n"
      w "#{tab * 2} * Expected    : #{i[:expected]}\n"
      w "#{tab * 2} * Result      : #{i[:result]}\n"
    end
  end
end
