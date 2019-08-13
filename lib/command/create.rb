# frozen_string_literal: true

require_relative '../project/project_creator.rb'

# Teuton#create
class Teuton < Thor
  map ['c', '-c', '--create'] => 'create'
  desc 'create PATH/TO/PROJECT/DIR', 'Create skeleton for a new project'
  long_desc <<-LONGDESC
  Create files for a new project: foo.rb, foo.yaml and .gitignore

  Example:

  #{$PROGRAM_NAME} create foo/demo

  LONGDESC
  def create(path_to_new_dir)
    ProjectCreator.create(path_to_new_dir)
  end
end
