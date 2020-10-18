# frozen_string_literal: true

require_relative '../application'
require_relative 'name_file_finder'

# Project module: functions invoked by CLI project tool
module Project
  ##
  # Check teuton test syntax
  # @param projectpath (String) Path to teuton test
  # @param options (Array) Array of input options
  def self.check(projectpath, options)
    Application.instance.add_input_options options
    NameFileFinder.find_filenames_for(projectpath)
    # NameFileFinder.puts_input_info_on_screen
    require_dsl_and_script('laboratory/laboratory') # Define DSL keywords

    app = Application.instance
    lab = Laboratory.new(app.script_path, app.config_path)
    lab.show_config if options[:panel]
    lab.show_dsl unless options[:panel]
  end

  ##
  # Run test
  # @param projectpath (String) Path to teuton test
  # @param options (Array) Array of input options
  def self.play(projectpath, options)
    Application.instance.add_input_options options
    NameFileFinder.find_filenames_for(projectpath)
    # NameFileFinder.puts_input_info_on_screen
    require_dsl_and_script('../case_manager/dsl') # Define DSL keywords
  end

  ##
  # Create Readme file for a test
  # @param projectpath (String) Path to teuton test
  # @param options (Array) Array of input options
  def self.readme(projectpath, options)
    Application.instance.add_input_options options
    NameFileFinder.find_filenames_for(projectpath)
    require_dsl_and_script('readme/readme') # Define DSL keywords

    app = Application.instance
    readme = Readme.new(app.script_path, app.config_path)
    readme.show
  end

  private_class_method def self.require_dsl_and_script(dslpath)
    app = Application.instance
    require_relative dslpath
    begin
      require_relative app.script_path
    rescue SyntaxError => e
      puts e.to_s
      puts Rainbow.new("[ERROR] SyntaxError into file #{app.script_path}").red
    end
  end
end
