# frozen_string_literal: true

# Methods Module RakeFunction
# * opensuse
# * debian
# * install_gems
module RakeFunction
  def self.opensuse(packages)
    names = ['openssh', 'make', 'gcc', 'ruby-devel']
    options = '--non-interactive'
    names.each do |n|
      system("zypper #{options} install #{n}")
    end
    install_gems packages, '--no-ri'
    create_symbolic_link
  end

  def self.debian(packages)
    names = ['ssh', 'make', 'gcc', 'ruby-dev']
    names.each { |name| system("apt-get install -y #{name}") }
    install_gems packages, '--no-ri'
    create_symbolic_link
  end

  def self.install_gems(list, options = '')
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
end
