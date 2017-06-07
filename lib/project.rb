
require 'fileutils'
require 'rainbow'

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
      config_path = File.join(File.dirname(script_path), File.basename(script_path, '.rb') + '.json')
      unless File.exist? config_path
        config_path = File.join(File.dirname(script_path), File.basename(script_path, '.rb') + '.yaml')
      end
      test_name = File.basename(script_path, '.rb')
    end
    print Rainbow('[INFO] ScriptPath => ').blue
    puts Rainbow(script_path).blue.bright
    print Rainbow('[INFO] ConfigPath => ').blue
    puts Rainbow(config_path).blue.bright
    print Rainbow('[INFO] TestName   => ').blue
    puts Rainbow(test_name).blue.bright

    return script_path, config_path, test_name
  end

  def self.laboratory(pathtofile)
    app = Application.instance
    app.script_path, app.config_path, app.test_name = find_filenames_for(pathtofile)

    require_relative 'laboratory'
    require_relative "../#{app.script_path}"
    lab = Laboratory.new("../#{app.script_path}", app.config_path)
    lab.whatihavetodo
  end

  def self.run(pathtofile)
    #$SCRIPT_PATH, $CONFIG_PATH, $TESTNAME = find_filenames_for(pathtofile)
    app = Application.instance
    app.script_path, app.config_path, app.test_name = find_filenames_for(pathtofile)

    require_relative 'sysadmingame'
    require_relative "../#{app.script_path}"
  end
end
