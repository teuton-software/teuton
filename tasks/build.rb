
namespace :build do
  desc 'Build gem'
  task :gem do
    puts '[ INFO ] Building gem...'
    run_cmd "rm #{Teuton::GEMNAME}-*.*.*.gem"
    run_cmd "gem build #{Teuton::GEMNAME}.gemspec"
  end

  desc 'Build docker image'
  task :docker do
    puts '[ INFO ] Building docker image...'
    run_cmd "docker rmi #{Teuton::DOCKERNAME}"
    run_cmd "docker build -t #{Teuton::DOCKERNAME} install/docker/"
  end

  desc 'Build all'
  task :all do
    Rake::Task['build:gem'].invoke
    Rake::Task['build:docker'].invoke
  end
end
