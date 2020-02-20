# frozen_string_literal: true

require_relative 'packages'
# Methods Module RakeFunction
# * opensuse
# * debian
# * install_gems
namespace :install do

  desc 'Install gems'
  task :gems do
    install_gems(packages)
  end

  desc 'Debian installation'
  task :debian do
    names = %w[ssh make gcc ruby-devel]
    names.each { |name| system("apt-get install -y #{name}") }
    install_gems packages, '--no-ri'
    create_symbolic_link
  end

  desc 'OpenSUSE installation'
  task :opensuse do
    names = %w[openssh make gcc ruby-devel]
    options = '--non-interactive'
    names.each do |n|
      system("zypper #{options} install #{n}")
    end
    install_gems packages, '--no-ri'
    create_symbolic_link
  end

  def install_gems(list, options = '')
    fails = filter_uninstalled_gems(list)
    if !fails.empty?
      puts "[INFO] Installing gems (options = #{options})..."
      fails.each do |name|
        system("gem install #{name} #{options}")
      end
    else
      puts '[ OK ] Gems installed'
    end
  end

  def create_symbolic_link
    if File.exist? '/usr/local/bin/teuton'
      puts '[WARN] Exist file /usr/local/bin/teuton!'
      return
    end
    puts '[INFO] Creating symbolic link into /usr/local/bin'
    basedir = File.dirname(__FILE__)
    system("ln -s #{basedir}/teuton '/usr/local/bin/teuton'")
  end
end
