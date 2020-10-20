# frozen_string_literal: true

require 'thor'
require_relative 'application'
require_relative 'project/project'
require_relative 'skeleton'
require_relative 'cli/main'

##
# Command Line User Interface
class CLI < Thor
  map ['h', '-h', '--help'] => 'help'

  map ['v', '-v', '--version'] => 'version'
  desc 'version', 'Show the program version'
  ##
  # Display teuton version
  def version
    puts "#{Application::NAME} (version #{Application::VERSION})"
  end

  map ['c', '-c', '--check'] => 'check'
  option :panel, type: :boolean
  option :cname, type: :string
  option :cpath, type: :string
  desc 'check [OPTIONS] DIRECTORY',
       'Check test and config file content'
  long_desc <<-LONGDESC

  (1) teuton check path/to/dir/foo
  , Test content of start.rb and config.yaml files.

  (2) teuton check path/to/dir/foo --cname=demo
  , Test content of start.rb and demo.yaml files.

  (3) teuton check path/to/file/foo.rb
  , Test content of foo.rb and foo.yaml files.

  (4) teuton check path/to/file/foo.rb --cname=demo
  , Test content of foo.rb and demo.yaml files.

  LONGDESC
  ##
  # Verify or test Teuton test units syntax
  # @param path_to_rb_file [String] Route to main rb Teuton file
  def check(path_to_rb_file)
    Project.check(path_to_rb_file, options)
  end

  map ['n', '-n', '--new'] => 'new'
  desc 'new DIRECTORY', 'Create skeleton for a new project'
  long_desc <<-LONGDESC
  Create files for a new project.
  LONGDESC
  ##
  # Command: create new Teuton project
  def new(path_to_new_dir)
    Skeleton.create(path_to_new_dir)
  end

  map ['--readme'] => 'readme'
  option :lang, type: :string
  desc 'readme DIRECTORY',
       'Show README.md file from test contents'
  long_desc <<-LONGDESC

  (1) teuton readme foo
  , Create README.md from foo/start.rb.

  (2) teuton readme foo/demo.rb
  , Create README.md from foo/demo.rb.
  LONGDESC

  ##
  # Create README from teuton test
  # @param path_to_rb_file [String] Route to main rb Teuton file
  def readme(path_to_rb_file)
    Project.readme(path_to_rb_file, options)
  end

  ##
  # These inputs are equivalents:
  # * teuton dir/foo
  # * teuton run dir/foo
  # * teuton play dir/foo
  def method_missing(method, *_args, &_block)
    play(method.to_s)
  end

  ##
  # Respond to missing methods name
  def respond_to_missing?(method_name, include_private = false)
    super
  end
end
