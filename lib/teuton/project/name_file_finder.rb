# frozen_string_literal: true

require 'rainbow'
require_relative '../application'

# Project:
# * find_filenames_for, verbose, verboseln
module NameFileFinder
  ##
  # Find project filenames from input project relative path
  # @param relprojectpath (String)
  def self.find_filenames_for(relprojectpath)
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

  ##
  # Find project filenames from input folder path
  # @param folder_path (String)
  def self.find_filenames_from_directory(folder_path)
    # COMPLEX MODE: We use start.rb as main RB file
    script_path = File.join(folder_path, 'start.rb')
    unless File.exist? script_path
      print Rainbow('[ERROR] File ').red
      print Rainbow(script_path).bright.red
      puts Rainbow(' not found!').red
      exit 1
    end

    app = Application.instance
    app.project_path = folder_path
    app.script_path = script_path
    app.test_name = folder_path.split(File::SEPARATOR)[-1]

    find_configfilename_from_directory(folder_path)
  end

  ##
  # Find project config filename from input folder path
  # @param folder_path (String)
  def self.find_configfilename_from_directory(folder_path)
    # COMPLEX MODE: We use config.yaml by default
    app = Application.instance

    config_path = ''
    if app.options['cpath'].nil?
      config_name = 'config'
      # Config name file is introduced by cname arg option from teuton command
      config_name = app.options['cname'] unless app.options['cname'].nil?
      config_path = File.join(folder_path, "#{config_name}.json")
      unless File.exist? config_path
        config_path = File.join(folder_path, "#{config_name}.yaml")
      end
    else
      # Config path file is introduced by cpath arg option from teuton command
      config_path = app.options['cpath']
    end
    app.config_path = config_path
  end

  def self.find_filenames_from_rb(script_path)
    # SIMPLE MODE: We use script_path as main RB file
    # This must be fullpath to DSL script file
    if File.extname(script_path) != '.rb'
      print Rainbow('[ERROR] Script ').red
      print Rainbow(script_path).bright.red
      puts Rainbow(' must have rb extension').red
      exit 1
    end

    app = Application.instance
    app.project_path = File.dirname(script_path)
    app.script_path = script_path
    app.test_name = File.basename(script_path, '.rb')

    find_configfilenames_from_rb(script_path)
  end

  def self.find_configfilenames_from_rb(script_path)
    # SIMPLE MODE: We use script_path as main RB file
    # This must be fullpath to DSL script file
    app = Application.instance

    config_path = ''
    if app.options['cpath'].nil?
      config_name = File.basename(script_path, '.rb')
      # Config name file is introduced by cname arg option from teuton command
      config_name = app.options['cname'] unless app.options['cname'].nil?

      config_path = File.join(app.project_path, config_name + '.json')
      unless File.exist? config_path
        config_path = File.join(app.project_path, config_name + '.yaml')
      end
    else
      # Config path file is introduced by cpath arg option from teuton command
      config_path = app.options['cpath']
    end
    app.config_path = config_path
  end

  def self.puts_input_info_on_screen
    app = Application.instance

    verbose Rainbow('[INFO] ScriptPath => ').blue
    verboseln Rainbow(trim(app.script_path)).blue.bright
    verbose Rainbow('[INFO] ConfigPath => ').blue
    verboseln Rainbow(trim(app.config_path)).blue.bright
    verbose Rainbow('[INFO] Pwd        => ').blue
    verboseln Rainbow(app.running_basedir).blue.bright
    verbose Rainbow('[INFO] TestName   => ').blue
    verboseln Rainbow(trim(app.test_name)).blue.bright
  end

  ##
  # Trim string text when is too long
  # @param input (String)
  # @return String
  def self.trim(input)
    return input unless input.to_s.start_with? Dir.pwd.to_s

    output = input.to_s
    offset = (Dir.pwd).length + 1
    output = "#{input[offset, input.size]}"
    output.to_s
  end

  def self.verboseln(text)
    verbose(text + "\n")
  end

  def self.verbose(text)
    return unless Application.instance.verbose
    return if Application.instance.options['quiet']
    print text
  end
end
