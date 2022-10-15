# frozen_string_literal: true

require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList["test/**/*_test.rb"]
end

require "standard/rake"
task default: %i[test standard]

#require_relative 'tasks/build'
#require_relative 'tasks/install'
#require_relative 'tasks/push'

desc 'Default: run tests'
task :default do
  Rake::Task['test'].invoke
end

desc 'Help'
task :help do
  system("rake -T")
end

desc 'Delete output files'
task :clean do
  system("rm -r #{File.join('var', '*')}")
end
