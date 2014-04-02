#File: Rakefile
#Usage: rake

#Define tasks
desc "Clean temp files."
task :clean do
	system("rm -rf var/tmp/*")
end

desc "FIRST installation (Debian)"
task :debian_install => [:debpackages, :rubygems, :auxdirs]

desc "Installing packages on Debian"
task :debpackages do
	system("apt-get install -y nmap ssh")
end

desc "Installing rubygems"
task :rubygems do
	system("gem install net-ssh net-sftp rspec")
end

desc "Creating auxiliar directories"
task :auxdirs do
	system("chmod +x check/demos/*.rb")
	system("mkdir -p var/mnt")
	system("mkdir -p var/out")
	system("mkdir -p var/tmp")
end
