# frozen_string_literal: true

##
# Group general functions used by Rakefile tasks
module Utils
  def self.gemlist
    gemnames = %w(colorize, rainbow)
    gemnames << %w(net-sftp net-ssh net-telnet)
    gemnames << %w(os json_pure thor terminal-table)
    gemnames
  end

  def self.create_symbolic_link
    if File.exist? '/usr/local/bin/teuton'
      puts '[WARN] Exist file /usr/local/bin/teuton!'
      return
    end
    puts '[INFO] Creating symbolic link into /usr/local/bin'
    basedir = File.join(File.dirname(__FILE__), '..')
    run_cmd "ln -s #{basedir}/teuton '/usr/local/bin/teuton'"
  end

  def self.install_gems(list, options = '')
    fails = filter_uninstalled_gems(list)
    if !fails.empty?
      puts "[INFO] Installing gems (options = #{options})..."
      fails.each do |name|
        run_cmd "gem install #{name} #{options}"
      end
    else
      puts '[  OK  ] Gems installed'
    end
  end

  def self.filter_uninstalled_gems(list)
    cmd = `gem list`.split("\n")
    names = cmd.map { |i| i.split(' ')[0] }
    fails = []
    list.each { |i| fails << i unless names.include?(i) }
    fails
  end

  def self.check_tests
    puts "[ INFO ] teuton version #{Teuton::VERSION}"
    testfile = File.join('.', 'tests', 'all.rb')
    a = File.read(testfile).split("\n")
    b = a.select { |i| i.include? '_test' }
    d = File.join('.', 'tests', '**', '*_test.rb')
    e = Dir.glob(d)
    puts "[ FAIL ] Some ruby tests are not executed by #{testfile}" unless b.size == e.size
    puts "[ INFO ] Running #{testfile}"
    run_cmd testfile
  end
end
