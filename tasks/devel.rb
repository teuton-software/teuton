namespace :devel do
  desc "OpenSUSE installation"
  task :opensuse do
    names = %w[openssh make gcc ruby-devel]
    options = "--non-interactive"
    names.each { |n| system("zypper #{options} install #{n}") }
  end

  desc "Debian installation"
  task :debian do
    names = %w[ssh make gcc ruby-dev]
    names.each { |name| system("apt install -y #{name}") }
  end

  desc "Create /usr/local/bin/teuton"
  task :launcher do
    launcherpath = "/usr/local/bin/teuton"
    if File.exist?(launcherpath)
      warn "File exist! (#{launcherpath})"
      exit 1
    end

    rubypath = `rbenv which ruby`.strip
    teutonpath = File.join(Dir.pwd, "teuton")

    puts "# Created with: 'rake devel:launcher'"
    puts "# - Copy this content into: #{launcherpath}"
    puts "# - Then: chmod +x #{launcherpath}"
    puts "RUBYPATH=#{rubypath}"
    puts "TEUTONPATH=#{teutonpath}"
    puts "$RUBYPATH $TEUTONPATH $@"
  end
end
