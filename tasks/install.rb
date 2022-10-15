namespace :install do
  desc "Debian installation"
  task :debian do
    names = %w[ssh make gcc ruby-devel]
    names.each { |name| system("apt-get install -y #{name}") }
    create_symbolic_link
  end

  desc "OpenSUSE installation"
  task :opensuse do
    names = %w[openssh make gcc ruby-devel]
    options = "--non-interactive"
    names.each { |n| system("zypper #{options} install #{n}") }
    create_symbolic_link
  end

  def create_symbolic_link
    if File.exist? "/usr/local/bin/teuton"
      puts "[WARN] Exist file /usr/local/bin/teuton!"
      return
    end
    puts "[+] Creating symbolic link into /usr/local/bin"
    basedir = File.join(File.dirname(__FILE__), "..")
    run_cmd "ln -s #{basedir}/teuton /usr/local/bin/teuton"
  end
end
