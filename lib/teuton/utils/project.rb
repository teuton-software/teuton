require_relative "name_file_finder"

##
# Class is used to store global parameters of the running project
class Project
  def self.init
    @project = {}
    @project[:running_basedir] = Dir.getwd
    @project[:output_basedir] = "var"
    @project[:name] = "teuton"
    @project[:format] = :txt # Default export format
    @project[:debug] = false # Disable/enable local executions
    @project[:options] = { # Default input options
      "color" => true,
      "lang" => "en",
      "panel" => false,
      "quiet" => false
    }
    @project[:verbose] = true
    @project[:global] = {} # Hash of Global configuration params
    @project[:ialias] = {} # Hash of Internal alias
    @project[:macros] = {} # Hash of macros
    @project[:groups] = [] # Array of groups
    @project[:uses] = [] # Array of used files into test
    @project[:hall_of_fame] = [] # Hall of fame content
  end

  def self.value
    @project
  end

  init

  # def self.name
  #   value[:name]
  # end

  def self.quiet?
    return true if value[:options]["quiet"]
    return true unless value[:verbose]

    false
  end

  def self.verbose
    value[:verbose]
  end

  ##
  # Preprocess input options:
  # * Convert input case options String to an Array of integers
  # * Read color input option
  def self.add_input_params(projectpath, options)
    value[:options].merge! options
    Rainbow.enabled = value[:options]["color"]

    finder = NameFileFinder.new(value[:options])
    finder.find_filenames_for(projectpath)
    value[:project_path] = finder.project_path
    value[:script_path] = finder.script_path
    value[:config_path] = finder.config_path
    value[:test_name] = finder.test_name

    return if value[:options]["case"].nil?

    numbers = value[:options]["case"].split(",")
    value[:options]["case"] = numbers.collect!(&:to_i)
  end
end
