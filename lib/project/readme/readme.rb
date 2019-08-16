# frozen_string_literal: true

require_relative '../../application'
require_relative '../../case_manager/case/result/result'
require_relative 'dsl'
require_relative 'lang'

def use(filename)
  filename += '.rb'
  app = Application.instance
  rbfiles = File.join(app.project_path, '**', filename)
  files = Dir.glob(rbfiles)
  use = []
  files.sort.each { |f| use << f if f.include?(filename) }
  require_relative use[0]
end

def group(name, &block)
  Application.instance.groups << { name: name, block: block }
end
alias task group

def start(&block)
  # don't do nothing
end
alias play start

# Creates README.md file from RB script file
class Readme
  attr_reader :result
  attr_reader :data

  def initialize(script_path, config_path)
    @path = {}
    @path[:script]   = script_path
    @path[:dirname]  = File.dirname(script_path)
    @path[:filename] = File.basename(script_path, '.rb')
    @path[:config]   = config_path
    reset
  end

  def reset
    @verbose = Application.instance.verbose
    @result = Result.new
    @data = {}
    @data[:logs] = []
    @data[:groups] = []
    @data[:play] = []
    @action = nil
    @getter = []
  end

  def process_content
    Application.instance.groups.each do |g|
      @current = { name: g[:name], actions: [] }
      @data[:groups] << @current
      instance_eval(&g[:block])
    end
  end

  def show
    process_content
    show_head

    @data[:groups].each do |group|
      puts "\n## #{group[:name]}\n\n"
      host = nil
      group[:actions].each_with_index do |item, index|
        if item[:host].nil? && index.positive?
          item[:host] = group[:actions][0][:host]
        end
        if host.nil? || item[:host] != host
          host = item[:host]
          puts format(Lang::get(:goto), host.upcase)
        end

        weight = ''
        weight = "(x#{item[:weight]}) " if item[:weight] != 1.0
        puts "* #{weight}#{item[:target]}"
      end
    end
  end

  def show_head
    app = Application.instance
    puts '```'
    puts format(Lang::get(:testname), app.test_name)
    puts format(Lang::get(:date), Time.now)
    puts '```'
    puts '---'
    puts "# README.md\n"

    unless @getter.empty?
      puts Lang::get(:params)
      @getter.uniq.sort.each { |i| puts "* #{i}" }
    end
  end
end
