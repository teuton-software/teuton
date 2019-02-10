
class Teuton < Thor

  map ['p', '-p', 'play', '--play'] => 'play'
  option :export, :type => :string
  desc 'play PATH/TO/FILE/FOO.rb', 'Run activity script file'
  long_desc <<-LONGDESC

Let's see some examples.

  teuton demo/foo.rb => Run challenge from <demo/foo.rb>

  teuton demo/foo       => Run challenge from <demo/foo/start.rb>.

  teuton play demo/foo.rb => Run challenge from <demo/foo.rb>

  teuton play demo/foo    => Run challenge from <demo/foo/start.rb>.

  teuton play --export=json demo/foo.rb => Export json format files

  teuton play --export=json demo/foo    => Export json format files

 Export formats availables: txt, colored_text, yaml, json.

LONGDESC
  def play(path_to_rb_file)
    Application.instance.options.merge! options
    Project.play(path_to_rb_file)
  end
end
