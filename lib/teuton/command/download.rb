# frozen_string_literal: true

require 'rainbow'

# Class method Teuton#download
class Teuton < Thor
  map ['-dc', '--dc', '--download'] => 'download'
  desc 'download', 'Download Teuton challenges from git repo'
  long_desc <<-LONGDESC
  - Download Teuton challenges from git repo.

  - Same as:
    git clone https://github.com/teuton-software/teuton-challenges.git

  Example:

  #{$PROGRAM_NAME} download

  LONGDESC
  def download
    repo = 'teuton-challenges'
    puts "[INFO] Downloading <#{repo}> repo..."
    ok = system("git clone https://github.com/teuton-software/#{repo}.git")
    if ok
      puts "[INFO] Your files are into <#{Rainbow(repo).bright}> directory..."
    else
      puts Rainbow('[ERROR] Ensure: ').red
      puts Rainbow('  1. Git is installed.').red
      puts Rainbow('  2. Your Internet connection is working.').red
    end
  end
end
