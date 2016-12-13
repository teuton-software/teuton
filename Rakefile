# File: Rakefile
# Usage: rake

packages = ['net-ssh', 'net-sftp', 'rainbow', 'terminal-table']
packages += ['minitest', 'pry-byebug']

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
    puts 'Check gems OK!'
  else
    puts 'Check gems FAILS!: ' + fails.join(',')
  end

  testfile = './tests/all.rb'
  a = `cat #{testfile}|grep "_test"|wc -l`
  b = `vdir -R tests/ |grep "_test.rb"|wc -l`
  if a.to_i == b.to_i
    puts "[ OK ] All ruby tests into #{testfile}"
  else
    puts "[FAIL] some ruby tests are not into #{testfile}"
  end

  puts "[INFO] Running #{testfile}"
  system(testfile)
end

desc 'Clean temp files.'
task :clean do
  system('rm -rf var/*')
end

desc 'Debian installation'
task debian: :gems do
  names = ['ssh', 'make', 'gcc', 'ruby-dev']
  names.each { |name| system("apt-get install -y #{name}") }
end

desc 'OpenSUSE installation'
task opensuse: :gems do
  names = ['openssh', 'rubygem-pry', 'make', 'gcc', 'ruby-devel']
  options = '--non-interactive --auto-agree-with-licenses'
  names.each { |n| system("zypper #{options} install #{n}") }
end

desc 'Install gems'
task :gems do
  # TODO: use gem pony to send email
  packages.each { |n| system("gem install #{n}") }
end

desc 'Creating auxiliar directories'
task :create_auxdirs do
  system('chmod +x ./check/demos/*.rb')
  system('mkdir -p var')
end
