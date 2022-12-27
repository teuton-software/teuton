require "erb"
require_relative "yaml"
require_relative "../../../application"

class ResumeHTMLFormatter < ResumeYAMLFormatter
  def initialize(report)
    super(report)
    @ext = "html"
    @data = {}
    basedir = File.join(File.dirname(__FILE__), "..", "..", "..")
    filepath = File.join(basedir, "files", "template", "resume.html")
    @template = File.read(filepath)
  end

  def process(options = {})
    build_data(options)
    build_page
    deinit
  end

  def build_page
    render = ERB.new(@template)
    w render.result(binding)
  end

  private

  def config
    @data[:config]
  end

  def cases
    @data[:cases]
  end

  def results
    @data[:results]
  end

  def hall_of_fame
    @data[:hall_of_fame]
  end

  def version
    Application::VERSION
  end
end
