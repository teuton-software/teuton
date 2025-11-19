# frozen_string_literal: true

require "bundler/gem_tasks"
require "rake/testtask"

# Run tests excluding slow tests
Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.test_files = FileList["test/**/*_test.rb"].exclude(/slow_|test_slow/)
end

# Run all tests
Rake::TestTask.new(:test_all) do |t|
  t.libs << "test"
  t.test_files = FileList["test/**/*_test.rb"]
end

require "standard/rake"
require_relative "tasks/docker"
require_relative "tasks/devel"

desc "Default: run tests and standard"
task :default do
  Rake::Task["test"].invoke
  Rake::Task["standard"].invoke
end

desc "Help"
task :help do
  system("rake -T")
end

desc "Delete output files"
task :clean do
  system("rm -r #{File.join("var", "*")}")
end
