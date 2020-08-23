require 'thor'
require_relative 'application'
require_relative 'project/project'
require_relative 'project/skeleton.rb'
require_relative 'cli/main'

##
# Command Line User Interface
class CLI < Thor
  map ['h', '-h', '--help'] => 'help'

  map ['c', '-c', '--create', 'create'] => 'new'
  desc 'new DIRECTORY', 'Create skeleton for a new project'
  long_desc <<-LONGDESC
  Create files for a new project.

  Example:

  #{$PROGRAM_NAME} create dir/foo
  LONGDESC
  ##
  # Command: create new Teuton project
  def new(path_to_new_dir)
    Skeleton.create(path_to_new_dir)
  end

  ##
  # These inputs are equivalents:
  # * teuton dir/foo
  # * teuton run dir/foo
  # * teuton play dir/foo
  def method_missing(method, *_args, &_block)
    play(method.to_s)
  end

  def respond_to_missing?(method_name, include_private = false)
    super
  end
end
