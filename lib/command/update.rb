
class Teuton < Thor

  map ['--pull'] => 'pull'
  desc 'pull', 'Pull remote files fromgit repo to current local dir'
  long_desc  <<-LONGDESC
  Execute "git pull".

  Example:

  #{$PROGRAM_NAME} pull

LONGDESC
  def pull
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
