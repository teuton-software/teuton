# frozen_string_literal: true

require_relative '../application'
require_relative 'name_file_finder'

# Project functions invoked by CLI project tool
# * test
# * play
# * process_input_case_option
# * readme
# * require_dsl_and_script
module Project  ##
  ##
  # Check teuton test syntax
  # @param projectpath (String) Path to teuton test
  # @param options (Array) Array of input options
  def self.check(projectpath, options)
    Application.instance.options.merge! options
    NameFileFinder.find_filenames_for(projectpath)
    NameFileFinder.puts_input_info_on_screen
    require_dsl_and_script('laboratory/laboratory') # Define DSL keywords

    app = Application.instance
    lab = Laboratory.new(app.script_path, app.config_path)
    # lab.show_requests if options[:r]
    lab.show_config if options[:c]
    lab.show_dsl unless options[:r] || options[:c]
  end

  ##
  # Run test
  # @param projectpath (String) Path to teuton test
  # @param options (Array) Array of input options
  def self.play(projectpath, options)
    Application.instance.options.merge! options
    process_input_options
    NameFileFinder.find_filenames_for(projectpath)
    NameFileFinder.puts_input_info_on_screen
    require_dsl_and_script('../case_manager/dsl') # Define DSL keywords
  end

  ##
  # Preprocess input options:
  # * Convert input case options String to an Array of integers
  # * Read color input option
  def self.process_input_options
    options = Application.instance.options
    options['color'] = true if options['color'].nil?
    Rainbow.enabled = options['color']
    return if options['case'].nil?

    a = options['case'].split(',')
    options['case'] = a.collect!(&:to_i)
  end

  ##
  # Create Readme file for a test
  # @param projectpath (String) Path to teuton test
  # @param options (Array) Array of input options
  def self.readme(projectpath, options)
    Application.instance.options.merge! options
    NameFileFinder.find_filenames_for(projectpath)
    require_dsl_and_script('readme/readme') # Define DSL keywords

    app = Application.instance
    readme = Readme.new(app.script_path, app.config_path)
    readme.show
  end

  def self.require_dsl_and_script(dslpath)
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
