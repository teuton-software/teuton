#File: Rakefile
#Usage: rake

packages=['net-ssh', 'net-sftp', 'rainbow', 'terminal-table', 'minitest', 'pry-byebug' ]

desc "Check installation"
task :check do
  cmd=(`gem list`).split("\n")
  names = cmd.map { |i| i.split(" ")[0]}
  fails = []
  packages.each { |i| fails << i unless names.include?(i) }

  if fails.size==0
    puts "Check OK!"
  else
    puts "Check FAILS!: "+fails.join(",")
 end
 system("./test/suit.rb")
end

#Define tasks
desc "Clean temp files."
task :clean do
  system("rm -rf var/*")
end

desc "Debian installation"
task :debian => [:gems] do
  names=[ 'ssh', 'make', 'gcc', 'ruby-dev' ]
  names.each { |name| system("apt-get install -y #{name}") }
end

desc "OpenSUSE installation"
task :opensuse => [:gems] do
  names=[ 'openssh', 'rubygem-pry', 'make', 'gcc', 'ruby-devel' ]
  names.each { |n| system("zypper --non-interactive in --auto-agree-with-licenses #{n}") }
end

desc "Install gems"
task :gems do
  #gem: pony?
  packages.each { |n| system("gem install #{n}") }
end

desc "Creating auxiliar directories"
task :create_auxdirs do
  system("chmod +x ./check/demos/*.rb")
  system("mkdir -p var")
end
