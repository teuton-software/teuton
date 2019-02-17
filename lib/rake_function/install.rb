# Methods Module RakeFunction
# * debian
# * opensuse
# * install_gems
module RakeFunction
  def self.debian(packages)
    names = ['ssh', 'make', 'gcc', 'ruby-dev']
    names.each { |name| system("apt-get install -y #{name}") }
    install_gems packages
    create_symbolic_link
  end

  # INFO
  # * gems     -> packages += ['pry-byebug']
  # * OpenSUSE -> 'ruby2.5-rubygem-pry',

  def self.opensuse(packages)
    names = ['openssh', 'make', 'gcc', 'ruby-devel']
    options = '--non-interactive'
    names.each { |n| system("zypper #{options} install #{n}") }
    install_gems packages
    create_symbolic_link
  end

  def self.install_gems(list)
    fails = filter_uninstalled_gems(list)
    if !fails.empty?
      puts '[INFO] Installing gems...'
      fails.each { |name| system("gem install #{name}") }
    else
      puts '[ OK ] Gems installed'
    end
  end
end
