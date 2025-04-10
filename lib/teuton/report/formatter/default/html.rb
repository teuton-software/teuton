require "erb"
require_relative "yaml"

class HTMLFormatter < YAMLFormatter
  def initialize(report)
    super
    @ext = "html"
    @data = {}
    basedir = File.join(File.dirname(__FILE__), "..", "..", "..")
    filepath = File.join(basedir, "files", "template", "case.html")
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
end
