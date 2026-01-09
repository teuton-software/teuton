require_relative "../utils/project"
require_relative "../utils/settings"
require_relative "formatter/formatter"

class Report
  attr_accessor :id, :filename, :output_dir, :head, :lines, :tail, :format
  attr_reader :history

  def initialize(id = "00")
    @id = id
    @filename = "case-#{@id}"
    @output_dir = Project.value[:output_basedir]
    @head = {}
    @lines = []
    @tail = {unique_fault: 0}
    # [String] with 1 char for every target in @lines
    # For example: "..F." means: good, good, fail and good
    @history = ""
  end

  def clone
    report = Report.new
    attrs = %i[id filename output_dir head lines tail format]
    attrs.each do |attr|
      attr_set = :"#{attr}="
      report.send(attr_set, send(attr).clone)
    end

    report
  end

  def export(options)
    filepath = File.join(@output_dir, @filename)
    Formatter.call(self, options, filepath)
  end

  def export_resume(options)
    format = options[:format]
    @format = :"resume_#{format}"
    options[:format] = @format
    filepath = File.join(@output_dir, @filename)
    Formatter.call(self, options, filepath)

    filepath = File.join(@output_dir, "moodle")
    Formatter.call(self, {format: :moodle_csv}, filepath)
  end

  ##
  # Calculate final values:
  # * grade
  # * max_weight
  # * good_weight,d
  # * fail_weight
  # * fail_counter
  def close
    max = good = fails = fail_counter = 0
    @lines.each do |i|
      next unless i.instance_of? Hash

      max += i[:weight] if i[:weight].positive?
      if i[:check]
        good += i[:weight]
        @history += Settings.letter[:good]
      else
        fails += i[:weight]
        fail_counter += 1
        @history += Settings.letter[:fail]
      end
    end
    @tail[:max_weight] = max
    @tail[:good_weight] = good
    @tail[:fail_weight] = fails
    @tail[:fail_counter] = fail_counter

    i = good.to_f / max
    i = 0 if i.nan?
    @tail[:grade] = (100.0 * i).round
    @tail[:grade] = 0 if @tail[:unique_fault].positive?
  end
end
