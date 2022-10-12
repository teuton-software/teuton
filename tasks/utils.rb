
module Utils
  def self.create_symbolic_link
    if File.exist? '/usr/local/bin/teuton'
      puts '[WARN] Exist file /usr/local/bin/teuton!'
      return
    end
    puts '[+] Creating symbolic link into /usr/local/bin'
    basedir = File.join(File.dirname(__FILE__), '..')
    run_cmd "ln -s #{basedir}/teuton '/usr/local/bin/teuton'"
  end

  def self.check_tests
    puts "[+] teuton version #{Teuton::VERSION}"
    testfile = File.join('.', 'tests', 'all.rb')
    a = File.read(testfile).split("\n")
    b = a.select { |i| i.include? '_test' }
    d = File.join('.', 'tests', '**', '*_test.rb')
    e = Dir.glob(d)
    puts "[FAIL] Some ruby tests are not executed by #{testfile}" unless b.size == e.size
    puts "[+] Running #{testfile}"
    run_cmd testfile
  end
end
