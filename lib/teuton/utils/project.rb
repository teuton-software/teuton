require_relative "name_file_finder"

##
# Class is used to store global parameters of the running project
class Project
  def self.init
    @project = {}
    @project[:running_basedir] = Dir.getwd
    @project[:output_basedir] = "var"
    @project[:output_dir] = @project[:output_basedir]
    @project[:base_case_id] = "00"
    @project[:name] = "teuton"
    @project[:format] = :txt # Default export format
    @project[:debug] = false # Disable/enable local executions
    @project[:options] = { # Default input options
      "color" => true,
      "lang" => "en",
      "panel" => false,
      "quiet" => false
    }
    @project[:verbose] = true # Enable/disable screen outputs
    @project[:ialias] = {} # Hash of Internal alias
    @project[:global] = {}
    @project[:groups] = []
    @project[:hall_of_fame] = [] # Hall of fame content
    @project[:macros] = {}
    @project[:uses] = []
  end

  def self.value
    @project
  end

  init

  def self.quiet?
    return true if value[:options]["quiet"]
    return true unless value[:verbose]

    false
  end

  ##
  # Preprocess input options:
  # * Convert input case options String to an Array of integers
  # * Read color input option
  def self.add_options(projectpath, options)
    value[:options].merge! options
    Rainbow.enabled = value[:options]["color"]

    finder = NameFileFinder.new(value[:options])
    finder.find_filenames_for(projectpath)
    value[:project_path] = finder.project_path
    value[:script_path] = finder.script_path
    value[:config_path] = finder.config_path
    value[:testname] = finder.testname

    return if value[:options]["case"].nil?

    numbers = value[:options]["case"].split(",")
    value[:options]["case"] = numbers.collect!(&:to_i)
  end

  def self.add_config(configdata)
    # Load configurations from config file
    value[:ialias] = configdata[:alias] || {}
    value[:global] = configdata[:global] || {}
    value[:global][:tt_sequence] = false if value[:global][:tt_sequence].nil?
    running_basedir = "#{value[:running_basedir]}/"
    value[:global][:tt_script_path] = value[:script_path].gsub(running_basedir, "")
    value[:global][:tt_config_path] = value[:config_path].gsub(running_basedir, "")

    value[:testname] = value[:global][:tt_testname] if value[:global][:tt_testname]
    value[:output_dir] = (value[:global][:tt_output_dir] || File.join(value[:output_basedir], value[:testname]))
  end

  def self.relative_path(filepath)
    if filepath.start_with?(Dir.pwd)
      filepath[Dir.pwd.length + 1, filepath.length]
    else
      filepath
    end
  end
end
