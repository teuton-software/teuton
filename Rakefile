# frozen_string_literal: true

require_relative 'tasks/check'
require_relative 'tasks/install'
require_relative 'tasks/build'

desc 'Default: check'
task :default do
  Rake::Task['install:check'].invoke
end

desc 'Rake help'
task :help do
  system('rake -T')
end
