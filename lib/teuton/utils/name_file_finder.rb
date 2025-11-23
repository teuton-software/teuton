require "rainbow"

class NameFileFinder
  attr_reader :options
  attr_reader :project_path
  attr_reader :script_path
  attr_reader :config_path
  attr_reader :test_name

  def initialize(options = {})
    @options = options
    @project_path = nil
    @script_path = nil # Path to DSL script file
    @config_path = nil # Path to YAML config file
    @test_name = nil
  end

  ##
  # Find project filenames from input project relative path
  # @param relprojectpath (String)
  def find_filenames_for(relprojectpath)
    projectpath = File.absolute_path(relprojectpath)

    if File.directory?(projectpath)
      # COMPLEX MODE: main RB file is <start.rb>
      find_filenames_from_directory(projectpath)
    else
      # SIMPLE MODE: main RB file is We <pathtofile>
      find_filenames_from_rb(projectpath)
    end
    true
  end

  private

  def find_filenames_from_directory(folder_path)
    # Find project filenames into directory <folder path>
    # COMPLEX MODE: main RB file is <start.rb>
    script_path = File.join(folder_path, "start.rb")
    unless File.exist? script_path
      warn Rainbow("[ERROR] Main script file not found! <#{script_path}>").bright.red
      exit 1
    end

    @project_path = folder_path
    @script_path = script_path
    @test_name = folder_path.split(File::SEPARATOR)[-1]

    find_configfilename_from_directory(folder_path)
  end

  def find_configfilename_from_directory(folder_path)
    # Find project config filename into directory <folder path>
    # COMPLEX MODE: By default <config.yaml> is the confing file
    config_path = ""

    if options["cpath"].nil?
      config_name = "config"
      # Config name file is introduced by cname arg option from teuton command
      config_name = options["cname"] unless options["cname"].nil?
      config_path = File.join(folder_path, "#{config_name}.json")
      unless File.exist? config_path
        config_path = File.join(folder_path, "#{config_name}.yaml")
      end
    else
      # Config path file is introduced by cpath arg option from teuton command
      config_path = options["cpath"]
    end
    @config_path = config_path
  end

  def find_filenames_from_rb(script_path)
    # SIMPLE MODE: We use script_path as main RB file
    # This must be fullpath to DSL script file
    if File.extname(script_path) != ".rb"
      warn Rainbow("[ERROR] Main script file not found!").bright.red
      warn Rainbow("[ERROR] Not found <#{script_path}/start.rb>").white
      warn Rainbow("[ERROR] Not found <#{script_path}.rb>").white
      exit 1
    end

    @project_path = File.dirname(script_path)
    @script_path = script_path
    @test_name = File.basename(script_path, ".rb")
    find_configfilenames_from_rb(script_path)
  end

  def find_configfilenames_from_rb(script_path)
    # SIMPLE MODE: We use script_path as main RB file
    # This must be fullpath to DSL script file
    config_path = ""
    if options["cpath"].nil?
      config_name = File.basename(script_path, ".rb")
      # Config name file is introduced by cname arg option from teuton command
      config_name = options["cname"] unless options["cname"].nil?

      config_path = File.join(@project_path, config_name + ".json")
      unless File.exist? config_path
        config_path = File.join(@project_path, config_name + ".yaml")
      end
    else
      # Config path file is introduced by cpath arg option from teuton command
      config_path = options["cpath"]
    end
    @config_path = config_path
  end
end
