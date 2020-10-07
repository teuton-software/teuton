# frozen_string_literal: true

# CLI#play
class CLI < Thor
  map ['p', '-p', 'play', '--play', '--run', 'run'] => 'play'
  option :export, type: :string
  option :cname, type: :string
  option :cpath, type: :string
  option :case, type: :string
  option :color, type: :boolean
  option :quiet, type: :boolean
  desc '[run] [OPTIONS] DIRECTORY',
       'Run challenge from directory'
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
    Project.play(filepath, options)
  end
end
