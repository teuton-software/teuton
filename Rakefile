# frozen_string_literal: true

require_relative 'tasks/build'
require_relative 'tasks/install'
require_relative 'tasks/push'

puts '[INFO] "rake build:gem" must be run before this!'

desc 'Default: check'
task :default do
  Rake::Task['install:check'].invoke
end

desc 'Rake help'
task :help do
  system('rake -T')
end

desc 'Delete output files'
task :clean do
  system("rm -r #{File.join('var', '*')}")
end
