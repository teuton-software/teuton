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
    @script_path = nil
    @config_path = nil
    @test_name = nil
  end

  ##
  # Find project filenames from input project relative path
  # @param relprojectpath (String)
  def find_filenames_for(relprojectpath)
    projectpath = File.absolute_path(relprojectpath)

    # Define:
    #   script_path, must contain fullpath to DSL script file
    #   config_path, must contain fullpath to YAML config file
    if File.directory?(projectpath)
      # COMPLEX MODE: We use start.rb as main RB file
      find_filenames_from_directory(projectpath)
    else
      # SIMPLE MODE: We use pathtofile as main RB file
      find_filenames_from_rb(projectpath)
    end
    true
  end

  private

  def find_filenames_from_directory(folder_path)
    # Find project filenames from input folder path
    # COMPLEX MODE: We use start.rb as main RB file
    script_path = File.join(folder_path, "start.rb")
    unless File.exist? script_path
      warn Rainbow("[ERROR] File not found: #{script_path}").bright.red
      exit 1
    end

    @project_path = folder_path
    @script_path = script_path
    @test_name = folder_path.split(File::SEPARATOR)[-1]

    find_configfilename_from_directory(folder_path)
  end

  def find_configfilename_from_directory(folder_path)
    # Find project config filename from input folder path
    # COMPLEX MODE: We use config.yaml by default
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
      warn Rainbow("[ERROR] .rb extension required!").bright.red
      warn Rainbow("        #{script_path}").white
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
