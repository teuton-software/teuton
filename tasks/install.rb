# frozen_string_literal: true

require_relative 'utils'

namespace :install do
  desc 'Check installation'
  task :check do
    fails = Utils.filter_uninstalled_gems(Utils.gemlist)
    puts "[ FAIL ] Gems to install!: #{fails.join(',')}" unless fails == []
    Utils.check_tests
  end

  desc 'Install gems'
  task :gems do
    Utils.install_gems(Utils.packages)
  end

  desc 'Debian installation'
  task :debian do
    names = %w[ssh make gcc ruby-devel]
    names.each { |name| system("apt-get install -y #{name}") }
    # Utils.install_gems Utils.packages, '--no-ri'
    Utils.create_symbolic_link
  end

  desc 'OpenSUSE installation'
  task :opensuse do
    names = %w(openssh make gcc ruby-devel)
    options = '--non-interactive'
    names.each { |n| system("zypper #{options} install #{n}") }
    # Utils.install_gems Utils.packages, '--no-ri'
    Utils.create_symbolic_link
  end
end
