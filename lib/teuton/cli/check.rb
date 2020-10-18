# frozen_string_literal: true

require_relative '../project/project'

# CLI#test
class CLI < Thor
  map ['t', '-t', '--test', 'test'] => 'check'
  option :panel, type: :boolean
  option :cname, type: :string
  option :cpath, type: :string
  desc 'check [OPTIONS] DIRECTORY',
       'Test or check test content'
  long_desc <<-LONGDESC

  (1) teuton check path/to/dir/foo
  , Test content of start.rb and config.yaml files.

  (2) teuton check path/to/dir/foo --cname=demo
  , Test content of start.rb and demo.yaml files.

  (3) teuton check path/to/file/foo.rb
  , Test content of foo.rb and foo.yaml files.

  (4) teuton check path/to/file/foo.rb --cname=demo
  , Test content of foo.rb and demo.yaml files.

  LONGDESC
  ##
  # Verify or test Teuton test units syntax
  # @param path_to_rb_file [String] Route to main rb Teuton file
  def check(path_to_rb_file)
    Project.check(path_to_rb_file, options)
  end
end
