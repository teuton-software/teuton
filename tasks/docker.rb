require_relative "../lib/teuton/version"

namespace :docker do
  desc "Build docker image"
  task :build do
    image = Teuton::DOCKERNAME
    puts "==> [INFO] Building docker image <#{image}>"
    system("docker rmi #{image}")
    system("docker build -t #{image} install/docker")
    system("docker tag #{image}:latest #{image}:#{Teuton::VERSION}")
  end

  desc "Run docker container"
  task :run do
    name = "teuton"
    image = Teuton::DOCKERNAME
    volume = Dir.pwd

    system("docker run -it --rm --name #{name} -v #{volume}:/opt -w /opt #{image}")
  end

  desc "Push docker"
  task :push do
    image = "dvarrui/asker"
    puts "[INFO] Pushing docker..."
    system("docker push #{image}:latest")
    system("docker push #{image}:#{Teuton::VERSION}")
  end
end
