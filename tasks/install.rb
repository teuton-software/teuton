
require_relative 'utils'

namespace :install do
  desc 'Check installation'
  task :check do
    Utils.check_tests
  end

  desc 'Debian installation'
  task :debian do
    names = %w[ssh make gcc ruby-devel]
    names.each { |name| system("apt-get install -y #{name}") }
    Utils.create_symbolic_link
  end

  desc 'OpenSUSE installation'
  task :opensuse do
    names = %w(openssh make gcc ruby-devel)
    options = '--non-interactive'
    names.each { |n| system("zypper #{options} install #{n}") }
    Utils.create_symbolic_link
  end
end
