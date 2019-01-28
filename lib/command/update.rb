
class Teuton < Thor

  map ['--update'] => 'update'
  desc 'update', 'Update local files from git repo'
  long_desc  <<-LONGDESC
  Execute "git pull".

  Example:

  #{$PROGRAM_NAME} update

LONGDESC
  def update
    system("git pull")
  end

  map ['--upgrade'] => 'upgrade'
  desc 'upgrade', 'Upgrade TEUTON software from git repo'
  long_desc  <<-LONGDESC
  Execute "cd PATH/TO/TEUTON/DIR && git pull".

  Example:

  #{$PROGRAM_NAME} upgrade

LONGDESC
  def upgrade
    system("cd /opt/teuton && git pull")
  end
end
