# frozen_string_literal: true

require_relative '../application'
require_relative 'create.rb'
require_relative 'find.rb'

# Project functions invoked by CLI project tool
# * test
# * play
# * create: copyfile, create_dir, create_dirs, create
# * find: find_filenames_for, verbose, verboseln
module Project
  def self.test(pathtofile, options)
    app = Application.instance
    find_filenames_for(pathtofile)

    require_relative 'laboratory' # Define DSL keywords
    require_relative app.script_path
    lab = Laboratory.new(app.script_path, app.config_path)
    # lab.show_requests if options[:r]
    lab.show_config if options[:c]
    lab.show_dsl unless options[:r] || options[:c]
  end

  def self.play(pathtofile)
    app = Application.instance
    find_filenames_for(pathtofile)

    require_relative '../case_manager/dsl' # Define DSL keywords
    begin
      require_relative app.script_path
    rescue SyntaxError => e
      puts e.to_s
      puts Rainbow.new("[ERROR] SyntaxError into file #{app.script_path}").red
    end
  end
end
