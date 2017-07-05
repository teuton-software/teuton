# File: Rakefile
# Usage: rake
require 'fileutils'

packages = ['net-ssh', 'net-sftp', 'rainbow', 'terminal-table']
packages += ['minitest', 'pry-byebug', 'thor', 'json']

desc 'Default'
task default: :check do
end

desc 'Check installation'
task :check do
  cmd = `gem list`.split("\n")
  names = cmd.map { |i| i.split(' ')[0] }
  fails = []
  packages.each { |i| fails << i unless names.include?(i) }

  if fails.size.zero?
    puts '[ OK ] Gems installed OK!'
  else
    puts '[ERROR] Gems to install!: ' + fails.join(',')
  end

  testfile = File.join('.', 'tests', 'all.rb')
  a = File.read(testfile).split("\n")
  b = a.select { |i| i.include? '_test' }

  d = File.join('.', 'tests', '**', '*_test.rb')
  e = Dir.glob(d)

  if b.size == e.size
    puts "[ OK ] All ruby tests are executed by #{testfile}"
  else
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
  packages.each { |n| system("gem install #{n}") }
end

desc 'OpenSUSE installation'
task :opensuse do
  names = ['openssh', 'ruby2.1-rubygem-pry', 'make', 'gcc', 'ruby-devel']
  options = '--non-interactive'
  names.each { |n| system("zypper #{options} install #{n}") }
  packages.each { |n| system("gem install #{n}") }
end

desc 'Install gems'
task :gems do
  # TODO: use gem pony to send email
  packages.each { |n| system("gem install #{n}") }
end

desc 'Update project'
task :update do
  system('git pull')
  packages.each { |n| system("gem install #{n}") }
end
