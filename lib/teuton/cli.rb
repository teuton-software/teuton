# frozen_string_literal: true

require 'thor'
require_relative 'application'
require_relative '../teuton'

##
# Command Line Interface
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
  option :panelconfig, type: :boolean
  option :cname, type: :string
  option :cpath, type: :string
  desc 'check [OPTIONS] DIRECTORY',
       'Check test and config file content'
  long_desc <<-LONGDESC

  (1) teuton check path/to/dir/foo
  , Check content of start.rb and config.yaml files.

  (2) teuton check path/to/dir/foo --cname=demo
  , Check content of start.rb and demo.yaml files.

  (3) teuton check path/to/file/foo.rb
  , Check content of foo.rb and foo.yaml files.

  (4) teuton check path/to/file/foo.rb --cname=demo
  , Check content of foo.rb and demo.yaml files.

  LONGDESC
  ##
  # Verify or test Teuton test units syntax
  # @param projectpath [String] Route to main rb Teuton file
  def check(projectpath)
    Teuton.check(projectpath, options)
  end

  # map ['--config'] => 'config'
  # option :global, type: :boolean
  # desc 'config [OPTIONS] DIRECTORY',
  #     'Suggest config file content'
  ##
  # Sugget config file content
  # @param projectpath [String] Route to main rb Teuton file
  # def config(projectpath)
  #  Teuton.check(projectpath, options)
  # end

  map ['--run', 'run'] => 'play'
  option :export, type: :string
  option :cname, type: :string
  option :cpath, type: :string
  option :case, type: :string
  option :color, type: :boolean
  option :quiet, type: :boolean
  desc '[run] [OPTIONS] DIRECTORY',
       'Run test from directory'
  long_desc <<-LONGDESC
  This function execute challenge from specified directory.
  By default, show progress on the screen.

  Let's see others options:

  (1) teuton foo, run challenge from foo/start.rb with foo/config.yaml config file.

  (2) teuton run foo, same as (1).

  (3) teuton run --export=json foo, run challenge and export using json format.
  Others output formats availables are: txt, html, yaml, json and colored_text.

  (4) teuton run --cname=demo foo, run challenge from foo/start.rb with foo/demo.yaml config file.

  (5) teuton foo/demo.rb, Run challenge from foo/demo.rb with foo/demo.yaml config file.

  LONGDESC
  ##
  # Execute Teuton test unit
  # @param filepath [String] Route to main: rb file or folder
  def play(filepath)
    Teuton.play(filepath, options)
  end

  map ['n', '-n', '--new'] => 'new'
  desc 'new DIRECTORY', 'Create skeleton for a new project'
  long_desc <<-LONGDESC
  Create files for a new project.
  LONGDESC
  ##
  # Command: create new Teuton project
  def new(projectpath)
    Teuton.create(projectpath)
  end

  map ['r', '-r', '--readme'] => 'readme'
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
  # @param projectpath [String] Route to main rb Teuton file
  def readme(projectpath)
    Teuton.readme(projectpath, options)
  end

  ##
  # These inputs are equivalents:
  # * teuton dir/foo
  # * teuton run dir/foo
  def method_missing(method, *_args, &_block)
    play(method.to_s)
  end

  ##
  # Respond to missing methods name
  def respond_to_missing?(method_name, include_private = false)
    super
  end
end
