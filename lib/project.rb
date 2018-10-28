
require 'fileutils'
require 'rainbow'
require_relative 'application'

# Project functions invoked by CLI project tool
module Project
  def self.create(pathtofile)
    projectname = File.basename(pathtofile)
    projectdir  = File.dirname(pathtofile)

    puts "\n[INFO] Creating project <#{Rainbow(projectname).bright}>"

    # Directory
    if Dir.exist? projectdir
      puts "* Exists directory!  => #{Rainbow(projectdir).yellow}"
    else
      puts "* Creating directory => #{Rainbow(projectdir).green}"
      Dir.mkdir(projectdir)
    end

    scriptfilepath = pathtofile + '.rb'
    copyfile('lib/config/lab.rb', scriptfilepath) # Ruby script

    configfilepath = pathtofile + '.yaml'
    copyfile('lib/config/lab.yaml', configfilepath) # Configfile

    gitignorefilepath = projectdir + '/.gitignore'
    copyfile('lib/config/gitignore', gitignorefilepath) # gitignore

    puts ''
  end

  def self.copyfile(target, dest)
    if File.exist? dest
      puts "* Exists file!       => #{Rainbow(dest).yellow}"
    else
      puts "* Creating file      => #{Rainbow(dest).green}"
      FileUtils.cp(target, dest)
    end
  end

  def self.laboratory(pathtofile)
    app = Application.instance
    find_filenames_for(pathtofile)

    require_relative 'laboratory'
    require_relative "../#{app.script_path}"
    lab = Laboratory.new("../#{app.script_path}", app.config_path)
    lab.whatihavetodo
  end

  def self.run(pathtofile)
    app = Application.instance
    find_filenames_for(pathtofile)

    require_relative 'sysadmingame'
    begin
      require_relative "../#{app.script_path}"
    rescue SyntaxError => e
      puts e.to_s
      puts "="*50
      puts "[ERROR] SyntaxError into file ../#{app.script_path}"
      puts "="*50
    end
  end

  def self.find_filenames_for(pathtofile)
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
      dirname = File.dirname(script_path)
      filename = File.basename(script_path, '.rb') + '.json'
      config_path = File.join(dirname, filename)
      unless File.exist? config_path
        dirname = File.dirname(script_path)
        filename = File.basename(script_path, '.rb') + '.yaml'
        config_path = File.join(dirname, filename)
      end
      test_name = File.basename(script_path, '.rb')
    end
    verbose Rainbow('[INFO] ScriptPath => ').blue
    verboseln Rainbow(script_path).blue.bright
    verbose Rainbow('[INFO] ConfigPath => ').blue
    verboseln Rainbow(config_path).blue.bright
    verbose Rainbow('[INFO] TestName   => ').blue
    verboseln Rainbow(test_name).blue.bright

    app = Application.instance
    app.script_path = script_path
    app.config_path = config_path
    app.test_name = test_name
    true
  end

  def self.verboseln(text)
    verbose(text + "\n")
  end

  def self.verbose(text)
    return unless Application.instance.verbose
    print text
  end
end
