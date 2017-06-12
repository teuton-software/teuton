
require 'singleton'
require 'rainbow'

# This Singleton contains application params
class Application
  include Singleton

  attr_reader   :name, :version, :letter, :output_basedir
  attr_reader   :debug
  attr_accessor :verbose
  attr_accessor :global, :tasks, :hall_of_fame
  attr_accessor :script_path, :config_path, :test_name

  def initialize
    @name = 'sysadmin-game'
    @version = '0.23.1'
    @letter = { good: '.', bad: 'F', error: '?', none: ' ' }
    @output_basedir = 'var'
    @debug = false
    @verbose = true

    @global = {}
    @tasks = []
    @hall_of_fame = []
  end

  def find_filenames_for(pathtofile)
    if pathtofile.nil? # Check param not null
      puts Rainbow('[ERROR] path-to-file not specified').red
      puts Rainbow('* Please, read help => ./project help').yellow
      exit 1
    end

    unless File.exist?(pathtofile) # Check file exists
      print Rainbow('[ERROR] ').red
      print Rainbow(pathtofile).bright.red
      puts Rainbow(" dosn't exists").red
      exit 1
    end

    # Define:
    #   script_path, must contain fullpath to DSL script file
    #   config_path, must contain fullpath to YAML config file

    if File.directory?(pathtofile)
      # COMPLEX MODE: We use start.rb as main RB file
      script_path = File.join(pathtofile, 'start.rb')
      config_path = File.join(pathtofile, 'config.json')
      unless File.exist? config_path
        config_path = File.join(pathtofile, 'config.yaml')
      end
      test_name = pathtofile.split(File::SEPARATOR)[-1]
    else
      # SIMPLE MODE: We use pathtofile as main RB file
      script_path = pathtofile # This must be fullpath to DSL script file
      if File.extname(script_path) != '.rb'
        print Rainbow('[ERROR] Script ').red
        print Rainbow(script_path).bright.red
        puts Rainbow(' must have rb extension').red
        exit 1
      end
      config_path = File.join(File.dirname(script_path), File.basename(script_path, '.rb') + '.json')
      unless File.exist? config_path
        config_path = File.join(File.dirname(script_path), File.basename(script_path, '.rb') + '.yaml')
      end
      test_name = File.basename(script_path, '.rb')
    end
    myverbose Rainbow('[INFO] ScriptPath => ').blue
    myverboseln Rainbow(script_path).blue.bright
    myverbose Rainbow('[INFO] ConfigPath => ').blue
    myverboseln Rainbow(config_path).blue.bright
    myverbose Rainbow('[INFO] TestName   => ').blue
    myverboseln Rainbow(test_name).blue.bright

    @script_path = script_path
    @config_path = config_path
    @test_name = test_name
    true
  end

  private

  def myverboseln(text)
    myverbose(text + "\n")
  end

  def myverbose(text)
    return unless Application.instance.verbose
    print text
  end
end
