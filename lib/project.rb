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
    $SCRIPTPATH=pathtofile   
    require_relative 'sysadmingame'
    require_relative "../#{$SCRIPTPATH}"
  end
  
end
