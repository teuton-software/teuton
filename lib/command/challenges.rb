
class Teuton < Thor

  map ['-dc', '--dc', '--download'] => 'download'
  desc 'download', 'Download Teuton challenges from git repo'
  long_desc  <<-LONGDESC
  Download Teuton challenges from git repo.
  You can do <git clone https://github.com/dvarrui/teuton-challenges.git> manually, or use this option.

  Example:

  #{$PROGRAM_NAME} download_challenges

LONGDESC
  def download
    puts "[INFO] Downloading <teuton-challenges> repo..."
#    system("cd #{current_dir} && git clone https://github.com/dvarrui/teuton-challenges.git")
    system("git clone https://github.com/dvarrui/teuton-challenges.git")
    puts "[INFO] Your files are into <#{Rainbow("teuton-challenges").bright}> directory..."
  end
end
