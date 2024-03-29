require "singleton"
require_relative "name_file_finder"

class Application
  include Singleton

  attr_reader :letter
  attr_reader :running_basedir, :output_basedir
  attr_reader :default
  attr_accessor :options
  attr_accessor :verbose
  attr_accessor :global # Global configuration params
  attr_accessor :ialias # Internal alias
  attr_accessor :uses # Array of uses
  attr_accessor :project_path, :script_path, :config_path, :test_name

  def initialize
    reset
  end

  def reset
    @letter = {
      good: ".",
      bad: "F",
      error: "?",
      none: " ",
      ok: "\u{2714}",
      cross: "\u{2716}"
    }
    @running_basedir = Dir.getwd
    @output_basedir = "var"
    @default = {name: "teuton", format: :txt, debug: false}
    @options = {
      "lang" => "en",
      "color" => true,
      "panel" => false
    }
    @verbose = true

    @global = {}
    @ialias = {}
    @uses = [] # TODO
  end

  def debug
    @default[:debug]
  end

  def name
    @default[:name]
  end

  def quiet?
    return true if Application.instance.options["quiet"]
    return true unless Application.instance.verbose

    false
  end

  ##
  # Preprocess input options:
  # * Convert input case options String to an Array of integers
  # * Read color input option
  def add_input_params(projectpath, options)
    @options.merge! options
    Rainbow.enabled = @options["color"]

    finder = NameFileFinder.new(@options)
    finder.find_filenames_for(projectpath)
    @project_path = finder.project_path
    @script_path = finder.script_path
    @config_path = finder.config_path
    @test_name = finder.test_name

    unless @options["case"].nil?
      numbers = @options["case"].split(",")
      @options["case"] = numbers.collect!(&:to_i)
    end
  end
end
