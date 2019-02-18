
class Teuton < Thor

  map ['p', '-p', 'play', '--play'] => 'play'
  option :export, :type => :string
  desc '[play] [--export=FORMAT] DIRECTORY', 'Run challenge from directory'
  long_desc <<-LONGDESC

This function execute challenge from specified directory.
By default, show progress on the screen.

Available EXPORT FORMATS are: txt, colored_text, json, yaml.

Let's see others options:
(1) teuton foo (Run challenge from foo/start.rb),
(2) teuton play foo (Run challenge from foo/start.rb),
(3) teuton play --export=json foo (Run challenge and export using json format),
(4) teuton foo/demo.rb (Run challenge from foo/demo.rb),
(5) teuton play foo/demo.rb (Run challenge from foo/demo.rb),
(6) teuton play --export=json foo/demo.rb (Export json format files)

LONGDESC
  def play(path_to_rb_file)
    Application.instance.options.merge! options
    Project.play(path_to_rb_file)
  end
end
