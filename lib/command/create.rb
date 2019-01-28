
class Teuton < Thor

  map ['c', '-c', '--create'] => 'create'
  desc 'create PATH/TO/DIR/PROJECT', 'Create files for a new project'
  long_desc  <<-LONGDESC
  Create files for a new project: foo.rb, foo.yaml and .gitignore

  Example:

  #{$PROGRAM_NAME} create challenges/demo/foo

LONGDESC
  def create(path_to_new_dir)
    Project.create(path_to_new_dir)
  end
end
