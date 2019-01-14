
require 'fileutils'
require 'rainbow'
require_relative 'application'

# Project functions invoked by CLI project tool
# * create
# * copyfile
# * laboratory
# * run
# * find_filenames_for
# * verboseln
# * verbose
module Project
  def self.create(pathtodir)
    projectdir  = pathtodir
    projectname = File.basename(pathtodir)

    puts "\n[INFO] Creating project <#{Rainbow(projectname).bright}>"

    # Directory
    if Dir.exist? projectdir
      puts "* Exists dir!        => #{Rainbow(projectdir).yellow}"
    else
      begin
        Dir.mkdir(projectdir)
        puts "* Creating dir        => #{Rainbow(projectdir).green}"
      rescue Exception => e
        puts "* Creating dir  ERROR => #{Rainbow(projectdir).red}"
      end
    end

    scriptfilepath = projectdir + '/start.rb'
    copyfile('lib/files/start.rb', scriptfilepath) # Ruby script

    configfilepath = projectdir + '/config.yaml'
    copyfile('lib/files/config.yaml', configfilepath) # Configfile

    gitignorefilepath = projectdir + '/.gitignore'
    copyfile('lib/files/gitignore', gitignorefilepath) # gitignore

    puts ''
  end

  def self.copyfile(target, dest)
    if File.exist? dest
      puts "* Exists file!        => #{Rainbow(dest).yellow}"
    else
      begin
        FileUtils.cp(target, dest)
        puts "* Creating file       => #{Rainbow(dest).green}"
      rescue Exception => e
        puts "* Creating file ERROR => #{Rainbow(dest).red}"
      end
    end
  end

  def self.laboratory(pathtofile, options)
    app = Application.instance
    find_filenames_for(pathtofile)

    require_relative 'project/laboratory'
    require_relative "../#{app.script_path}"
    lab = Laboratory.new("../#{app.script_path}", app.config_path)
    lab.show_requests if options[:r]
    lab.show_config if options[:c]
    lab.show_dsl unless (options[:r] or options[:c])
  end

  def self.run(pathtofile)
    app = Application.instance
    find_filenames_for(pathtofile)

    require_relative 'project/sysadmingame'
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
