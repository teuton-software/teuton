# frozen_string_literal: true

require "erb"
require_relative "resume_yaml_formatter"
require_relative "../../application"

##
# HTMLFormatter class receive a [Report] and generates HAML output.
class ResumeHTMLFormatter < ResumeYAMLFormatter
  def initialize(report)
    super(report)
    @data = {}
    filepath = File.join(File.dirname(__FILE__), "..", "..", "files", "template", "resume.html")
    @template = File.read(filepath)
  end

  def process
    build_data
    build_page
    deinit
  end

  def build_page
    config = @data[:config]
    cases = @data[:cases]
    results = @data[:results]
    hall_of_fame = @data[:hall_of_fame]
    version = Application::VERSION
    render = ERB.new(@template)

    # TODO
    # obiwan  = Data.new "obiwan", "jedi"
    # render.run(obiwan.get_binding)

    w render.result(binding)
  end

  class Data
    def initialize(config, cases, results, hall_of_fame, version)
      @config = config
      @cases = cases
      @results = results
      @hall_of_fame = hall_of_fame
      @version = version
    end

    # Support templating of member data.
    def get_binding
      binding
    end
  end
end
