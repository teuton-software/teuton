# frozen_string_literal: true

# Method RakeFunction#check
module RakeFunction
  def self.check(gems)
    fails = filter_uninstalled_gems(gems)
    puts "[ERROR] Gems to install!: #{fails.join(',')}" unless fails == []
    check_tests
  end

  def self.check_tests
    testfile = File.join('.', 'tests', 'all.rb')
    a = File.read(testfile).split("\n")
    b = a.select { |i| i.include? '_test' }

    d = File.join('.', 'tests', '**', '*_test.rb')
    e = Dir.glob(d)

    unless b.size == e.size
      puts "[FAIL] Some ruby tests are not executed by #{testfile}"
    end

    puts "[INFO] Running #{testfile}"
    system(testfile)
  end

  def self.filter_uninstalled_gems(list)
    cmd = `gem list`.split("\n")
    names = cmd.map { |i| i.split(' ')[0] }
    fails = []
    list.each { |i| fails << i unless names.include?(i) }
    fails
  end
end
