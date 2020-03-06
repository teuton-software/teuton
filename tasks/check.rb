# frozen_string_literal: true

require_relative 'packages'

# Method RakeFunction#check
namespace :install do
  desc 'Check installation'
  task :check do
    fails = filter_uninstalled_gems(packages)
    puts "[ERROR] Gems to install!: #{fails.join(',')}" unless fails == []
    check_tests
  end

  def check_tests
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

  def filter_uninstalled_gems(list)
    cmd = `gem list`.split("\n")
    names = cmd.map { |i| i.split(' ')[0] }
    fails = []
    list.each { |i| fails << i unless names.include?(i) }
    fails
  end
end
