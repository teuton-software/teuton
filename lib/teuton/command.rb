require 'thor'
require_relative 'application'
require_relative 'project/project'
require_relative 'project/project_creator.rb'
require_relative 'command/main'

##
# Command Line User Interface
class TeutonCommand < Thor
  map ['h', '-h', '--help'] => 'help'

  def method_missing(method, *_args, &_block)
    play(method.to_s)
  end

  def respond_to_missing?(method_name, include_private = false)
    super
  end

  map ['c', '-c', '--create'] => 'create'
  desc 'create DIRECTORY', 'Create skeleton for a new project'
  long_desc <<-LONGDESC
  Create files for a new project.

  Example:

  #{$PROGRAM_NAME} create dir/foo
  LONGDESC
  ##
  # Command create new Teuton project
  def create(path_to_new_dir)
    ProjectCreator.create(path_to_new_dir)
  end
end
