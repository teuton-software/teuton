# frozen_string_literal: true

require "bundler/gem_tasks"
require "rake/testtask"
require "standard/rake"
require_relative "tasks/docker"
require_relative "tasks/devel"
require_relative "tasks/test"

desc "Default: run tests and standard"
task :default do
  Rake::Task["test:fast"].invoke
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
