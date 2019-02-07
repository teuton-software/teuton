# File: Rakefile
# Usage: rake
require_relative 'lib/application'
require_relative 'lib/rake_function/check.rb'
require_relative 'lib/rake_function/install.rb'

packages = ['net-ssh', 'net-sftp', 'rainbow', 'terminal-table']
packages += ['thor', 'json', 'minitest']

desc 'Default: check'
task :default => :check do
end

desc 'Check installation'
task :check do
  RakeFunction.check(packages)
end

desc 'Debian installation'
task :debian do
  RakeFunction.debian(packages)
end

desc 'Install gems'
task :gems do
  RakeFunction.install_gems(packages)
end

desc 'Rake help'
task :help do
  system('rake -T')
end

desc 'OpenSUSE installation'
task :opensuse do
  RakeFunction.opensuse(packages)
end

def create_symbolic_link
  puts "[INFO] Creating symbolic link into /usr/local/bin"
  basedir = File.dirname(__FILE__)
  system("ln -s #{basedir}/teuton /usr/local/bin/teuton")
end
