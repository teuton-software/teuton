
require 'fileutils'

class Teuton < Thor

  map ['--clean'] => 'clean'
  desc 'clean', 'Clean temp files'
  def clean
    FileUtils.rm_rf(Dir.glob(File.join('.', 'var', '*')))
  end
end
