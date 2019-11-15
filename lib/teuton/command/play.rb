# frozen_string_literal: true

# Teuton#play
class TeutonCommand < Thor
  map ['p', '-p', 'play', '--play'] => 'play'
  option :export, type: :string
  option :cname, type: :string
  option :cpath, type: :string
  option :case, type: :string
  option :quiet, type: :boolean
  desc '[play] [OPTIONS] DIRECTORY',
       'Run challenge from directory'
  long_desc <<-LONGDESC
  This function execute challenge from specified directory.
  By default, show progress on the screen.

  Let's see others options:

  (1) teuton foo, run challenge from foo/start.rb with foo/config.yaml config file.

  (2) teuton play foo, same as (1).

  (3) teuton play --export=json foo, run challenge and export using json format.
  Others output formats availables are: txt, colored_text, json, yaml.

  (4) teuton play --cname=demo foo, run challenge from foo/start.rb with foo/demo.yaml config file.

  (5) teuton foo/demo.rb, Run challenge from foo/demo.rb with foo/demo.yaml config file.

  LONGDESC
  def play(path_to_rb_file)
    Project.play(path_to_rb_file, options)
  end
end
