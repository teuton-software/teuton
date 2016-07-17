#!/usr/bin/ruby
# encoding: utf-8
#

require 'fileutils'
require 'rainbow'

module Project
		
  def self.create(pathtofile)
  
    projectname = File.basename(pathtofile)
    projectdir  = File.dirname(pathtofile)
    
    puts "\n[INFO] Creating project <#{Rainbow(projectname).bright}>"

    # Directory
    if !Dir.exists? projectdir
      puts "* Creating directory => #{Rainbow(projectdir).color(:green)}"
      Dir.mkdir(projectdir)
    else
      puts "* Exists directory!  => #{Rainbow(projectdir).color(:yellow)}"
    end
    
    scriptfilepath=pathtofile+".rb" 
    copyfile("lib/config/lab.rb",scriptfilepath) # Ruby script

    configfilepath=pathtofile+".yaml" 
    copyfile("lib/config/lab.yaml",configfilepath) # Configfile
    
    gitignorefilepath=projectdir+"/.gitignore" 
    copyfile("lib/config/gitignore",gitignorefilepath) # gitignore
    
    puts "" 
  end

  def self.copyfile(target,dest)
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
    
    if not File.exists?(pathtofile) # Check file exists
      puts Rainbow("[ERROR] ").red+Rainbow(pathtofile).bright.red+Rainbow(" dosn't exists").red
      exit 1
    end
    
    # Define:
    #   lScriptPath, must contain fullpath to DSL script file
    #   lConfigPath, must contain fullpath to YAML config file

    if File.directory?(pathtofile) then
      lScriptPath = File.join( pathtofile, "start.rb")
      lConfigPath = File.join( pathtofile, "config.yaml")
      lTestName = pathtofile.split("/")[-1]
    else
      lScriptPath = pathtofile # This must be fullpath to DSL script file
      lConfigPath = File.join(File.dirname( lScriptPath ),File.basename( lScriptPath, ".rb")+".yaml")
      lTestName = File.basename( lScriptPath, ".rb")
    end
    puts Rainbow("[INFO] ScriptPath => #{lScriptPath}").blue
    puts Rainbow("[INFO] ConfigPath => #{lConfigPath}").blue
    puts Rainbow("[INFO]   TestName => #{lTestName}").blue

    return lScriptPath, lConfigPath, lTestName
  end

  def self.laboratory(pathtofile)
    lScriptPath, lConfigPath, lTestName = find_filenames_for(pathtofile)
    
    require_relative 'laboratory'
    require_relative "../#{lScriptPath}"
    lab =Laboratory.new("../#{lScriptPath}", "../#{lConfigPath}")
    lab.whatihavetodo
  end

  def self.run(pathtofile)
    $SCRIPT_PATH, $CONFIG_PATH, $TESTNAME = find_filenames_for(pathtofile)  

    require_relative 'sysadmingame'
    require_relative "../#{$SCRIPT_PATH}"
  end
  
end
