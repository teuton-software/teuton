# frozen_string_literal: true

require_relative 'teuton/application'
require_relative 'teuton/skeleton'

##
# Main Teuton functions
module Teuton
  ##
  # Create new Teuton project
  def self.create(path_to_new_dir)
    Skeleton.create(path_to_new_dir)
  end

  # Run test
  # @param projectpath (String) Path to teuton test
  # @param options (Array) Array of input options
  def self.play(projectpath, options = {})
    Application.instance.add_input_params(projectpath, options)
    require_dsl_and_script('teuton/case_manager/dsl') # Define DSL keywords
  end

  # Create Readme file for a test
  # @param projectpath (String) Path to teuton test
  # @param options (Array) Array of input options
  def self.readme(projectpath, options = {})
    Application.instance.add_input_params(projectpath, options)
    require_dsl_and_script('teuton/readme/readme') # Define DSL keywords

    app = Application.instance
    readme = Readme.new(app.script_path, app.config_path)
    readme.show
  end

  # Check teuton test syntax
  # @param projectpath (String) Path to teuton test
  # @param options (Array) Array of input options
  def self.check(projectpath, options = {})
    Application.instance.add_input_params(projectpath, options)
    require_dsl_and_script('teuton/check/laboratory') # Define DSL keywords

    app = Application.instance
    lab = Laboratory.new(app.script_path, app.config_path)
    lab.show unless options[:panelconfig]
    lab.show_panelconfig if options[:panelconfig]
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
