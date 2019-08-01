# frozen_string_literal: true

require_relative '../application'
require_relative 'create.rb'
require_relative 'find.rb'
require_relative 'laboratory/laboratory'

# Project functions invoked by CLI project tool
# * test
# * play
# * create: copyfile, create_dir, create_dirs, create
# * find: find_filenames_for, verbose, verboseln
module Project
  def self.test(pathtofile, options)
    find_filenames_for(pathtofile)
    require_dsl_and_script('laboratory/laboratory') # Define DSL keywords

    app = Application.instance
    lab = Laboratory.new(app.script_path, app.config_path)
    # lab.show_requests if options[:r]
    lab.show_config if options[:c]
    lab.show_dsl unless options[:r] || options[:c]
  end

  def self.play(pathtofile)
    find_filenames_for(pathtofile)
    require_dsl_and_script('../case_manager/dsl') # Define DSL keywords
  end

  def self.readme(pathtofile)
    find_filenames_for(pathtofile)
    require_dsl_and_script('readme/readme') # Define DSL keywords
    app = Application.instance
    readme = Readme.new(app.script_path, app.config_path)
    puts readme.data
  end

  def self.require_dsl_and_script(dslpath)
    app = Application.instance
    require_relative dslpath
    begin
      require_relative app.script_path
    rescue SyntaxError => e
      puts e.to_s
      puts Rainbow.new("[ERROR] SyntaxError into file #{app.script_path}").red
    end
  end
end
