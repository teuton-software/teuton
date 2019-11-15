# frozen_string_literal: true

# Teuton#readme
class TeutonCommand < Thor
  map ['r', '-r', '--readme'] => 'readme'
  option :lang, type: :string
  desc 'readme DIRECTORY',
       'Create README.md file from challenge contents'
  long_desc <<-LONGDESC

  (1) teuton readme foo
  , Create README.md from foo/start.rb.

  (2) teuton readme foo/demo.rb
  , Create README.md from foo/demo.rb.

  By default lang=es, but It's available lang=en too.

  LONGDESC
  def readme(path_to_rb_file)
    Project.readme(path_to_rb_file, options)
  end
end
