
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
    app.find_filenames_for(pathtofile)

    require_relative 'laboratory'
    require_relative "../#{app.script_path}"
    lab = Laboratory.new("../#{app.script_path}", app.config_path)
    lab.whatihavetodo
  end

  def self.run(pathtofile)
    app = Application.instance
    app.find_filenames_for(pathtofile)

    require_relative 'sysadmingame'
    require_relative "../#{app.script_path}"
  end
end
