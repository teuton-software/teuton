require "thor"
require_relative "version"
require_relative "../teuton"

class CLI < Thor
  map ["h", "-h", "--help"] => "help"

  map ["n", "-n", "--new"] => "new"
  desc "new DIRECTORY", "Create skeleton for a new project"
  long_desc <<-LONGDESC
  Create files for a new project.
  LONGDESC
  def new(projectpath)
    Teuton.create(projectpath)
  end

  map ["c", "-c", "--check"] => "check"
  option :onlyconfig, type: :boolean
  option :color, type: :boolean
  option :cname, type: :string
  option :cpath, type: :string
  desc "check [OPTIONS] DIRECTORY", "Check test and config file content"
  long_desc <<~LONGDESC

    (1) teuton check PATH/TO/DIR , Check content of start.rb and config.yaml files.

    (2) teuton check PATH/TO/DIR --cname=demo , Check content of start.rb and demo.yaml files:

    (3) teuton check PATH/TO/DIR --onlyconfig  , Only show config file recomendations

    (4) teuton check PATH/TO/DIR/foo.rb , Check content of foo.rb and foo.yaml files.

    (5) teuton check PATH/TO/DIR/foo.rb --cname=demo , Check content of foo.rb and demo.yaml files.

  LONGDESC
  def check(projectpath)
    Teuton.check(projectpath, options)
  end

  map ["--readme"] => "readme"
  option :lang, type: :string
  desc "readme DIRECTORY", "Show README extracted from test contents"
  long_desc <<-LONGDESC

  (1) teuton readme foo
  , Create README.md from foo/start.rb.

  (2) teuton readme foo/demo.rb
  , Create README.md from foo/demo.rb.
  LONGDESC

  def readme(projectpath)
    # Create README from teuton test
    Teuton.readme(projectpath, options)
  end

  map ["--run", "run"] => "play"
  option :export, type: :string
  option :cname, type: :string
  option :cpath, type: :string
  option :case, type: :string
  option :color, type: :boolean
  option :quiet, type: :boolean
  desc "[run] [OPTIONS] DIRECTORY", "Run test from directory"
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
  def play(filepath)
    Teuton.run(filepath, options)
  end

  map ["v", "-v", "--version"] => "version"
  desc "version", "Show the program version"
  def version
    puts "#{Teuton::APPNAME} version #{Teuton::VERSION}"
  end

  ##
  # These inputs are equivalents:
  # * teuton dir/foo
  # * teuton run dir/foo
  def method_missing(method, *_args, &_block)
    play(method.to_s)
  end

  def respond_to_missing?(method_name, include_private = false)
    # Respond to missing methods name
    super
  end
end
