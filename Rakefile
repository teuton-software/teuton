# frozen_string_literal: true

require_relative 'tasks/check'
require_relative 'tasks/install'

desc 'Default: check'
task :default do
  Rake::Task['install:check'].invoke
end

desc 'Rake help'
task :help do
  system('rake -T')
end

desc 'Build gem'
task :build do
  puts '[INFO] Building gem...'
  system('rm teuton-*.*.*.gem')
  system('gem build teuton.gemspec')
end

desc 'Generate docs'
task :docs do
  puts "[ INFO ] Generating documentation..."
  system('rm -r html/')
  system('yardoc lib/* -o html')
end
