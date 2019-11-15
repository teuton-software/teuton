require_relative 'application'
require_relative 'teuton/project/project_creator'

##
# Main Teuton functions
module Teuton
  ##
  # Create new Teuton project
  def self.create(path_to_new_dir)
    ProjectCreator.create(path_to_new_dir)
  end

  ##
  # Display Teuton version
  def self.version
    print Rainbow(Application::NAME).bright.blue
    puts  ' (version ' + Rainbow(Application::VERSION).green + ')'
  end
end
