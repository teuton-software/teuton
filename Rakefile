#File: Rakefile
#Usage: rake

#Define tasks
desc "Clean temp files."
task :clean do
	system("rm -rf var/*")
end

desc "Debian installation"
task :debian => [:debpackages, :install_gems, :create_auxdirs]

desc "_install deb packages "
task :debpackages do
	system("apt-get install -y ssh")
end

desc "OpenSUSE installation"
task :opensuse => [:zypperpackages, :install_gems, :create_auxdirs]

desc "_install rpm packages"
task :zypperpackages do
  names=[ 'openssh', 'rubygem-pry' ]
  names.each { |n| system("zypper --non-interactive in --auto-agree-with-licenses #{n}") }
end

desc "_install gems"
task :install_gems do
  names=['net-ssh', 'net-sftp', 'rspec', 'pony', 'rainbow', 'terminal-table']
  names.each { |n| system("gem install #{n}") }
end

desc "_creating auxiliar directories"
task :create_auxdirs do
	system("chmod +x ./check/demos/*.rb")
	system("mkdir -p var")
end
