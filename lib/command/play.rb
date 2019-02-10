
class Teuton < Thor

  map ['p', '-p', 'play', '--play'] => 'play'
  option :export, :type => :string
  desc '[play] [--export=FORMAT] DIRECTORY', 'Run challenge from directory'
  long_desc <<-LONGDESC

This function execute challenge from specified directory.

By default, it will be shown progress information on the screen.

Available EXPORT FORMATS: txt, colored_text, json, yaml.

Let's see some examples: teuton foo (Run challenge from <foo/start.rb>),
teuton play foo (Run challenge from <foo/start.rb>),
teuton play --export=json foo (Run challenge and export using json format),
teuton foo/demo.rb (Run challenge from <foo/demo.rb>),
teuton play foo/demo.rb (Run challenge from <foo/demo.rb>),
teuton play --export=json foo/demo.rb (Export json format files)

LONGDESC
  def play(path_to_rb_file)
    Application.instance.options.merge! options
    Project.play(path_to_rb_file)
  end
end
