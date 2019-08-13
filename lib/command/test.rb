# frozen_string_literal: true

# Teuton#test
class Teuton < Thor
  map ['t', '-t', '--test'] => 'test'
  option :c, type: :boolean
  option :cname, type: :string
  option :cpath, type: :string
  desc 'test DIRECTORY',
       'Test or check challenge contents'
  long_desc <<-LONGDESC

  (1) teuton test path/to/dir/foo
  , Test content of start.rb and config.yaml files.

  (2) teuton test path/to/dir/foo -c
  , Only test CONFIG information from config.yaml.

  (3) teuton test path/to/dir/foo --cname=demo
  , Test content of start.rb and demo.yaml files.

  (4) teuton test path/to/file/foo.rb
  , Test content of foo.rb and foo.yaml files.

  (5) teuton test path/to/file/foo.rb -c
  , Only test CONFIG information from foo.yaml.

  (6) teuton test path/to/file/foo.rb --cname=demo
  , Test content of foo.rb and demo.yaml files.

  LONGDESC
  def test(path_to_rb_file)
    Project.test(path_to_rb_file, options)
  end
end
