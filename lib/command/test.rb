
class Teuton < Thor

  map ['t', '-t', '--test'] => 'test'
  desc 'test PATH/TO/FILE/FOO.rb', 'Check challenge contents'
  option :r, :type => :boolean
  option :c, :type => :boolean
  long_desc <<-LONGDESC

  teuton test path/to/foo.rb
  , Test content of file <path/to/foo.rb>

  teuton test path/to/foo.rb -c
  , Only test CONFIG information from <path/to/foo.yaml>

LONGDESC
  def test(path_to_rb_file)
    Project.test(path_to_rb_file, options)
  end
end
