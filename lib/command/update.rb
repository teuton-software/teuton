
class Teuton < Thor

  map ['--upgrade'] => 'upgrade'
  desc 'upgrade', 'Upgrade TEUTON software from git repo'
  long_desc  <<-LONGDESC
  Execute "cd PATH/TO/TEUTON/DIR && git pull".

  Example:

  #{$PROGRAM_NAME} upgrade

LONGDESC
  def upgrade
    dir = File.absolute_path(File.join(File.dirname(__FILE__), '..', '..'))
    system("cd #{dir} && git pull")
  end
end
