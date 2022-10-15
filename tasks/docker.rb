require_relative "../lib/teuton/version"

namespace :docker do
  desc "Build docker image"
  task :build do
    puts "[INFO] Building docker image..."
    run_cmd "docker rmi #{Teuton::DOCKERNAME}"
    run_cmd "docker build -t #{Teuton::DOCKERNAME} install/docker/"
  end

  desc "Push docker"
  task :push do
    puts "[INFO] Pushing docker..."
    system("docker push dvarrui/teuton")
  end
end
