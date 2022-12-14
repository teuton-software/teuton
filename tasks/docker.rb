require_relative "../lib/teuton/version"

namespace :docker do
  desc "Build docker image"
  task :build do
    puts "[INFO] Building docker image..."
    system "docker rmi #{Teuton::DOCKERNAME}"
    system "docker build -t #{Teuton::DOCKERNAME} install/docker/"
  end

  desc "Push docker"
  task :push do
    puts "[INFO] Pushing docker..."
    system("docker push dvarrui/teuton")
  end
end
