
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

require_relative 'project/create.rb'
require_relative 'project/find.rb'

module Project

  def self.laboratory(pathtofile, options)
    app = Application.instance
    find_filenames_for(pathtofile)

    require_relative 'project/laboratory'
    require_relative app.script_path
    lab = Laboratory.new(app.script_path, app.config_path)
    lab.show_requests if options[:r]
    lab.show_config if options[:c]
    lab.show_dsl unless (options[:r] or options[:c])
  end

  def self.play(pathtofile)
    app = Application.instance
    find_filenames_for(pathtofile)

    require_relative 'case_manager/dsl'
    begin
      require_relative app.script_path
    rescue SyntaxError => e
      puts e.to_s
      puts "="*50
      puts "[ERROR] SyntaxError into file #{app.script_path}"
      puts "="*50
    end
  end
end
