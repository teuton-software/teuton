# frozen_string_literal: true

# Teuton#readme
class Teuton < Thor
  map ['r', '-r', '--readme'] => 'readme'
  option :lang, type: :string
  desc 'readme DIRECTORY',
       'Create README.md file from challenge contents'
  long_desc <<-LONGDESC

  teuton readme path/to/foo
  , Create README.md from <path/to/foo/start.rb>

  LONGDESC
  def readme(path_to_rb_file)
    Project.readme(path_to_rb_file, options)
  end
end
