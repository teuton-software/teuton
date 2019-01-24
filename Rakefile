# File: Rakefile
# Usage: rake
require 'fileutils'
require_relative 'lib/application'

packages = ['net-ssh', 'net-sftp', 'rainbow', 'terminal-table']
packages += ['thor', 'json', 'minitest']
#packages += ['pry-byebug']
challenges_repo = 'teuton-challenges'
challenges_dir = 'challenges'

desc 'Default'
task default: :check do
end

desc 'Check installation'
task :check do
  puts "[INFO] Version #{Application.instance.version}"
  fails = filter_uninstalled_gems(packages)

  unless fails.size.zero?
    puts '[ERROR] Gems to install!: ' + fails.join(',')
  end

  testfile = File.join('.', 'tests', 'all.rb')
  a = File.read(testfile).split("\n")
  b = a.select { |i| i.include? '_test' }

  d = File.join('.', 'tests', '**', '*_test.rb')
  e = Dir.glob(d)

  unless b.size == e.size
    puts "[FAIL] Some ruby tests are not executed by #{testfile}"
  end

  puts "[INFO] Running #{testfile}"
  system(testfile)
end

desc 'Clean temp files.'
task :clean do
  FileUtils.rm_rf(Dir.glob(File.join('.', 'var', '*')))
end

desc 'Debian installation'
task :debian do
  names = ['ssh', 'make', 'gcc', 'ruby-dev']
  names.each { |name| system("apt-get install -y #{name}") }
  install_gems packages
end

desc 'OpenSUSE installation'
task :opensuse do
  names = ['openssh', 'ruby2.5-rubygem-pry', 'make', 'gcc', 'ruby-devel']
  options = '--non-interactive'
  names.each { |n| system("zypper #{options} install #{n}") }
  install_gems packages
end

desc 'Install gems'
task :gems do
  install_gems packages
end

desc 'Update project'
task :update do
  puts "[INFO] Pulling <teuton> repo..."
  system('git pull')
  puts "[INFO] Pulling <#{challenges_repo}> repo..."
  system("cd #{challenges_dir}; git pull")
  install_gems packages
  system('ruby teuton version')
end

desc 'Get challenges from repository (user)'
task :get_challenges do
  puts "[INFO] getting challenges from repo..."
  system("git clone https://github.com/dvarrui/#{challenges_repo}.git")
  system("mv #{challenges_repo} #{challenges_dir}")
end

desc 'Get challenges from repository (dev)'
task :get_challenges_dev do
  puts "[INFO] getting challenges from repo..."
  system("git clone git@github.com:dvarrui/#{challenges_repo}.git")
  system("mv #{challenges_repo} #{challenges_dir}")
end

def install_gems(list)
  fails = filter_uninstalled_gems(list)
  if fails.size > 0
    puts "[INFO] Installing gems..."
    fails.each { |name| system("gem install #{name}") }
  else
    puts "[ OK ] Gems installed"
  end
end

def filter_uninstalled_gems(list)
  cmd = `gem list`.split("\n")
  names = cmd.map { |i| i.split(' ')[0] }
  fails = []
  list.each { |i| fails << i unless names.include?(i) }
  fails
end
