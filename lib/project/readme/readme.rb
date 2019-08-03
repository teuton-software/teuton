# frozen_string_literal: true

require_relative '../../application'
require_relative '../../case_manager/case/result'
require_relative 'dsl'

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
    @data[:actions] = []
    @action = nil
  end

  def process_content
    Application.instance.groups.each { |g| instance_eval(&g[:block]) }
  end

  def show
    process_content
    app = Application.instance
    puts '```'
    puts "Test name : #{app.test_name}"
    puts '```'
    puts '---'
    puts '# README.md'
    puts @data[:groups]
    @data[:actions].each do |i|
      puts "Action"
      puts " * #{i[:host]}: #{i[:target]}"
    end
  end
end
