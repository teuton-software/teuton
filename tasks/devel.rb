namespace :devel do
  desc "OpenSUSE installation"
  task :opensuse do
    names = %w[openssh make gcc ruby-devel]
    options = "--non-interactive"
    names.each { |n| system("zypper #{options} install #{n}") }
  end

  desc "Debian installation"
  task :debian do
    names = %w[ssh make gcc ruby-devel]
    names.each { |name| system("apt-get install -y #{name}") }
  end
end