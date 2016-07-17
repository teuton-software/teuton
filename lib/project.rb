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
  
  def self.laboratory(pathtofile)
    require_relative 'laboratory'
    require_relative "../#{pathtofile}"
    lab =Laboratory.new("../#{pathtofile}")
    lab.whatihavetodo
  end

  def self.run(pathtofile)
    if pathtofile.nil? # Check param not null
      puts Rainbow("[ERROR] path-to-file not specified").color(:red)
      puts Rainbow("* Please, read help => ./project help").color(:yellow)
      return
    end
    
    if not File.exists?(pathtofile) # Check file exists
      puts Rainbow("[ERROR] ").red+Rainbow(pathtofile).bright.red+Rainbow(" dosn't exists").red
      return
    end
    
    # Define:
    #   $SCRIPT_PATH, must contain fullpath to DSL script file
    #   $CONFIG_PATH, must contain fullpath to YAML config file

    if File.directory?(pathtofile) then
      $SCRIPT_PATH = File.join( pathtofile, "start.rb")
      $CONFIG_PATH = File.join( pathtofile, "config.yaml")
      $TESTNAME = pathtofile.split("/")[-1]
    else
      $SCRIPT_PATH=pathtofile # This must be fullpath to DSL script file
      $CONFIG_PATH = File.join(File.dirname($SCRIPT_PATH),File.basename($SCRIPT_PATH,".rb")+".yaml")
      $TESTNAME = File.basename($SCRIPT_PATH,".rb")
    end
    puts Rainbow("[INFO] SCRIPT_PATH => #{$SCRIPT_PATH}").blue
    puts Rainbow("[INFO] CONFIG_PATH => #{$CONFIG_PATH}").blue
    puts Rainbow("[INFO]    TESTNAME => #{$TESTNAME}").blue

    require_relative 'sysadmingame'
    require_relative "../#{$SCRIPT_PATH}"
  end
  
end
