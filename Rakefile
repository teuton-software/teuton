# File: Rakefile
# Usage: rake
require 'fileutils'
require_relative 'lib/application'

packages = ['net-ssh', 'net-sftp', 'rainbow', 'terminal-table']
packages += ['thor', 'json', 'minitest']

# INFO
# * gems     -> packages += ['pry-byebug']
# * OpenSUSE -> 'ruby2.5-rubygem-pry',

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
  create_symbolic_link
  chown_files
end

desc 'OpenSUSE installation'
task :opensuse do
  names = ['openssh', 'make', 'gcc', 'ruby-devel']
  options = '--non-interactive'
  names.each { |n| system("zypper #{options} install #{n}") }
  install_gems packages
  create_symbolic_link
  chown_files
end

desc 'Install gems'
task :gems do
  install_gems packages
end

desc 'Update project'
task :update do
  puts "[INFO] Pulling <teuton> repo..."
  system('git pull')
  install_gems packages
  system('ruby teuton version')
end

desc 'If your want sample TEUTON challenges'
task :challenges do
  puts "[INFO] If your want sample TEUTON challenges, do this:"
  puts "       cd PAHT/TO/YOUR/DOCUMENTS"
  puts "       git clone https://github.com/dvarrui/teuton-challenges.git"
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

def chown_files
  user = `who`.split(' ')[0]
  system("chown -R #{user} ../teuton")

  reponame = 'teuton-challenges'
  puts "[INFO] Downloading <#{reponame}> repo..."
  system("cd /home/#{user} && git clone https://github.com/dvarrui/#{reponame}.git")
  system("chown -R #{user} /home/#{user}/#{reponame}")
  puts "[INFO] Examples into /home/#{user}/#{reponame}"
end

def create_symbolic_link
  puts "[INFO] Creating symbolic link into /usr/local/bin"
  basedir = File.dirname(__FILE__)
  system("ln -s #{basedir}/asker /usr/local/bin/asker")
end
