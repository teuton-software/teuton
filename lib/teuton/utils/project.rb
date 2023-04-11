# Development in progress...

require_relative "name_file_finder"

class Project
  def self.init
    @project = {}
    @project[:running_basedir] = Dir.getwd
    @project[:output_basedir] = "var"
    @project[:name] = "teuton"
    @project[:format] = :txt
    @project[:debug] = false
    @project[:options] = {
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
    @project[:uses] = []   # TODO: Array of files used
    @project[:hall_of_fame] = []
    @project[:project_path] = nil
    @project[:script_path] = nil
    @project[:config_path] = nil
    @project[:test_name] = nil
  end

  def self.value
    @project
  end

  init

  def self.debug
    value[:debug]
  end

  def self.name
    value[:name]
  end

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
    NameFileFinder.find_filenames_for(projectpath)
    Rainbow.enabled = value[:options]["color"]

    unless value[:options]["case"].nil?
      numbers = value[:options]["case"].split(",")
      value[:options]["case"] = numbers.collect!(&:to_i)
    end
  end
end
