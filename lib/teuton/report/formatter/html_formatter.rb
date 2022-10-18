# frozen_string_literal: true

require "erb"
require_relative "yaml_formatter"
require_relative "../../application"

class HTMLFormatter < YAMLFormatter
  def initialize(report)
    super(report)
    @data = {}
    filepath = File.join(File.dirname(__FILE__), '..', '..', 'files', 'template', 'case.html')
    @template = File.read(filepath)
  end

  def process
    build_data
    build_page
    deinit
  end

  def build_page
    # config = @data[:config]
    # results = @data[:results]
    # logs = @data[:logs]
    # groups = @data[:groups]
    # hall_of_fame = @data[:hall_of_fame]
    # version = Application::VERSION
    render = ERB.new(@template)
    w render.result(binding)
  end

  private

  def config
    @data[:config]
  end

  def results
    @data[:results]
  end

  def logs
    @data[:logs]
  end

  def groups
    @data[:groups]
  end

  def hall_of_fame
    @data[:hall_of_fame]
  end

  def version
    Application::VERSION
  end
end
