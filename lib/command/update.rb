
class Teuton < Thor

  map ['--update'] => 'update'
  desc 'update', 'Update TEUTON from git repo'
  long_desc  <<-LONGDESC
  Execute "cd PATH/TO/TEUTON/DIR && git pull".

  Example:

  #{$PROGRAM_NAME} update

LONGDESC
  def update
    dir = File.absolute_path(File.join(File.dirname(__FILE__), '..', '..'))
    system("cd #{dir} && git pull")
  end
end
