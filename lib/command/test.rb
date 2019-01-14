
class Teuton < Thor

  map ['t', '-t', '--test'] => 'test'
  desc 'test PATH/TO/FILE/FOO.rb', 'Show laboratory script objectives on screen'
  option :r, :type => :boolean
  option :c, :type => :boolean
  long_desc <<-LONGDESC


  #{$PROGRAM_NAME} test path/to/foo.rb
  , Test content of file <path/to/foo.rb>

  #{$PROGRAM_NAME} test path/to/foo.rb -c
  , Test only CONFIG information from <path/to/foo.yaml>

  #{$PROGRAM_NAME} test path/to/foo.rb -r
  , Test only REQUEST information from  <path/to/foo.rb>


LONGDESC
  def test(path_to_rb_file)
    Project.laboratory(path_to_rb_file, options)
  end
end
