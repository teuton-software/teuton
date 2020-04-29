# frozen_string_literal: true

namespace :push do
  desc 'Push gem'
  task :gem do
    puts '[INFO] Pushing gem...'
    system('gem push teuton-*.*.*.gem')
  end

  desc 'Push docker'
  task :docker do
    puts '[INFO] Pushing docker...'
    system('docker push dvarrui/teuton')
  end

  desc 'Push all (gem and docker)'
  task :all do
    Rake::Task['push:gem'].invoke
    Rake::Task['push:docker'].invoke
  end
end
