# frozen_string_literal: true

# CLI#test
class CLI < Thor
  map ['t', '-t', '--test', 'test'] => 'check'
  option :c, type: :boolean
  option :cname, type: :string
  option :cpath, type: :string
  desc 'check [OPTIONS] DIRECTORY',
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
  ##
  # Verify or test Teuton test units syntax
  # @param path_to_rb_file [String] Route to main rb Teuton file
  def check(path_to_rb_file)
    Project.check(path_to_rb_file, options)
  end
end
