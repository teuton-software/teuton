require_relative "../utils/application"
require_relative "../utils/project"
require_relative "../utils/settings"
require_relative "formatter/formatter"

class Report
  attr_accessor :id, :filename, :output_dir
  attr_accessor :head
  attr_accessor :lines
  attr_accessor :tail
  attr_accessor :format
  attr_reader :history

  def initialize(id = "00")
    @id = id
    @filename = "case-#{@id}"
    # @output_dir = Application.instance.output_basedir
    @output_dir = Project.value[:output_basedir]
    @head = {}
    @lines = []
    @tail = {}
    # @history save 1 letter for every target.
    # For example: "..F." means: good, good, fail and good
    # I will use this in the future stats manager.
    @history = ""
  end

  def clone
    report = Report.new
    attrs = %i[id filename output_dir head lines tail format]
    attrs.each do |attr|
      attr_set = "#{attr}=".to_sym
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
    @format = "resume_#{format}".to_sym
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
    max = 0.0
    good = 0.0
    fail = 0.0
    fail_counter = 0
    @lines.each do |i|
      next unless i.instance_of? Hash

      max += i[:weight] if i[:weight].positive?
      if i[:check]
        good += i[:weight]
        @history += Settings.letter[:good]
      else
        fail += i[:weight]
        fail_counter += 1
        @history += Settings.letter[:bad]
      end
    end
    @tail[:max_weight] = max
    @tail[:good_weight] = good
    @tail[:fail_weight] = fail
    @tail[:fail_counter] = fail_counter

    i = good.to_f / max
    i = 0 if i.nan?
    @tail[:grade] = (100.0 * i).round
    @tail[:grade] = 0 if @tail[:unique_fault].positive?
  end
end
