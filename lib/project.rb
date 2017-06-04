
require 'fileutils'
require 'rainbow'

# Project functions invoked by CLI project tool
module Project
  def self.create(pathtofile)
    projectname = File.basename(pathtofile)
    projectdir  = File.dirname(pathtofile)

    puts "\n[INFO] Creating project <#{Rainbow(projectname).bright}>"

    # Directory
    if !Dir.exist? projectdir
      puts "* Creating directory => #{Rainbow(projectdir).color(:green)}"
      Dir.mkdir(projectdir)
    else
      puts "* Exists directory!  => #{Rainbow(projectdir).color(:yellow)}"
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
    if !File.exists? dest
      puts "* Creating file      => #{Rainbow(dest).color(:green)}"
      FileUtils.cp(target,dest)
    else
      puts "* Exists file!       => #{Rainbow(dest).color(:yellow)}"
    end
  end

  def self.find_filenames_for(pathtofile)
    if pathtofile.nil? # Check param not null
      puts Rainbow("[ERROR] path-to-file not specified").color(:red)
      puts Rainbow("* Please, read help => ./project help").color(:yellow)
      exit 1
    end

    if !File.exist?(pathtofile) # Check file exists
      puts Rainbow('[ERROR] ').red+Rainbow(pathtofile).bright.red+Rainbow(" dosn't exists").red
      exit 1
    end

    # Define:
    #   script_path, must contain fullpath to DSL script file
    #   config_path, must contain fullpath to YAML config file

    if File.directory?(pathtofile)
      script_path = File.join(pathtofile, 'start.rb')
      config_path = File.join(pathtofile, 'config.yaml')
      test_name = pathtofile.split(File::SEPARATOR)[-1]
    else
      script_path = pathtofile # This must be fullpath to DSL script file
      config_path = File.join(File.dirname(script_path), File.basename(script_path, '.rb') + '.yaml')
      test_name = File.basename(script_path, '.rb')
    end
    puts Rainbow('[INFO] ScriptPath => ').blue + Rainbow(script_path).blue.bright
    puts Rainbow('[INFO] ConfigPath => ').blue + Rainbow(config_path).blue.bright
    puts Rainbow('[INFO] TestName   => ').blue + Rainbow(test_name).blue.bright

    return script_path, config_path, test_name
  end

  def self.laboratory(pathtofile)
    script_path, config_path, _test_name = find_filenames_for(pathtofile)

    require_relative 'laboratory'
    require_relative "../#{script_path}"
    lab = Laboratory.new("../#{script_path}", "../#{config_path}")
    lab.whatihavetodo
  end

  def self.run(pathtofile)
    $SCRIPT_PATH, $CONFIG_PATH, $TESTNAME = find_filenames_for(pathtofile)

    require_relative 'sysadmingame'
    require_relative "../#{$SCRIPT_PATH}"
  end
end
