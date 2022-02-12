
require_relative 'lib/teuton/version'
require_relative 'tasks/build'
require_relative 'tasks/install'
require_relative 'tasks/push'

desc 'Default: check'
task :default do
  Rake::Task['install:check'].invoke
end

desc 'Rake help'
task :help do
  puts '[ REM  ] "rake install:gem" once time, before run "rake"'
  run_cmd 'rake -T'
end

desc 'Delete output files'
task :clean do
  run_cmd "rm -r #{File.join('var', '*')}"
end

def run_cmd(command)
  puts " => #{command}"
  ok = system(command)
  unless ok
    puts "[ FAIL ] Command execution error!"
  end
end
