require 'rainbow'

# Class method Teuton#update
class Teuton < Thor

  map ['--update', '-u', 'u'] => 'update'
#  desc 'update|u|-u|--update', 'Update TEUTON from git repo'
  desc 'update', 'Update TEUTON from git repo'
  long_desc  <<-LONGDESC
  Update TEUTON project, downloading files from git repo.
  Execute "cd PATH/TO/TEUTON/DIR && git pull".

  Alias: teuton u, teuton -u, teuton --update

LONGDESC
  def update
    dir = File.absolute_path(File.join(File.dirname(__FILE__), '..', '..'))
    ok = system("cd #{dir} && git pull")
    if ok
      puts Rainbow('[ OK ] teuton update').green.bright
      exit(0)
    else
      puts Rainbow('[FAIL] teuton update').red.bright
      exit(1)
    end
  end
end
