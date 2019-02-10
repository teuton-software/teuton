
class Teuton < Thor

  map ['p', '-p', 'play', '--play'] => 'play'
  desc 'play PATH/TO/FILE/FOO.rb', 'Run activity script file'
  long_desc <<-LONGDESC

  SIMPLE MODE: Run challenge from <challenges/demo/foo.rb>.

  Example: #{$PROGRAM_NAME} challenges/demo/foo.rb

  COMPLEX MODE: Run challenge from <challenges/demo/foo/start.rb>.

  Example: #{$PROGRAM_NAME} challenges/demo/foo

LONGDESC
  def play(path_to_rb_file)
    Project.play(path_to_rb_file)
  end
end
