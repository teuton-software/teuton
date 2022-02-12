
namespace :build do
  desc 'Build gem'
  task :gem do
    puts '[ INFO ] Building gem...'
    run_cmd "rm #{Version::GEMNAME}-*.*.*.gem"
    run_cmd "gem build #{Version::GEMNAME}.gemspec"
  end

  desc 'Generate docs'
  task :docs do
    puts '[ INFO ] Generating documentation...'
    run_cmd 'rm -r html/'
    run_cmd 'yardoc lib/* -o html'
  end

  desc 'Build docker image'
  task :docker do
    puts '[ INFO ] Building docker image...'
    run_cmd "docker rmi #{Version::DOCKERNAME}"
    run_cmd "docker build -t #{Version::DOCKERNAME} install/docker/"
  end

  desc 'Build all (gem and docs)'
  task :all do
    Rake::Task['build:gem'].invoke
    Rake::Task['build:docs'].invoke
  end
end
