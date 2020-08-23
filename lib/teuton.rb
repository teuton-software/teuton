require_relative 'teuton/application'
require_relative 'teuton/project/project'
require_relative 'teuton/project/skeleton'

##
# Main Teuton functions
module Teuton
  ##
  # Create new Teuton project
  def self.create(path_to_new_dir)
    Skeleton.create(path_to_new_dir)
  end

  ##
  # Play (run) Teuton project.
  # @param path_to_rb_file [String] Path to main rb file.
  # @param options [Hash] Options like
  # * :export [String]
  # * :cname [String]
  # * :cpath [String]
  # * :case [String]
  # * :quiet [Boolean]
  def self.play(path_to_rb_file, options = {})
    Project.play(path_to_rb_file, options)
  end

  ##
  # Generate readme for Teuton project.
  # @param path_to_rb_file [String] Path to main rb file.
  def self.readme(path_to_rb_file)
    Project.readme(path_to_rb_file, options)
  end

  ##
  # Simulate play Teuton project, check syntax and display stats.
  # @param path_to_rb_file [String] Path to main rb file.
  def self.check(path_to_rb_file)
    Project.check(path_to_rb_file, options)
  end

  ##
  # Display Teuton version
  def self.version
    print Rainbow(Application::NAME).bright.blue
    puts  ' (version ' + Rainbow(Application::VERSION).green + ')'
  end
end
