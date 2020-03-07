# frozen_string_literal: true

require 'terminal-table'
require 'rainbow'

require_relative '../../application'
require_relative '../../case_manager/case/result/result'
require_relative 'show'
require_relative 'dsl'
require_relative 'builtin'

##
# DSL use: import filename instructions
# @param filename (String)
def use(filename)
  filename += '.rb'
  app = Application.instance
  rbfiles = File.join(app.project_path, '**', filename)
  files = Dir.glob(rbfiles)
  use = []
  files.sort.each { |f| use << f if f.include?(filename) }
  require_relative use[0]
end

##
# DSL group: Define a group of test
# @param name (String or Symbol)
# @param block (Proc)
def group(name, &block)
  Application.instance.groups << { name: name, block: block }
end
alias task group

##
# DSL start: Define main teuton test execution
# @param block (Proc)
def start(&block)
  # don't do nothing
end
alias play start

# Show objectives stats from RB script file
class Laboratory
  attr_reader :result

  def initialize(script_path, config_path)
    @path = {}
    @path[:script]   = script_path
    @path[:dirname]  = File.dirname(script_path)
    @path[:filename] = File.basename(script_path, '.rb')
    @path[:config]   = config_path
    reset
  end

  def reset
    @result = Result.new
    @targetid = 0
    @stats = { groups: 0, targets: 0, uniques: 0, gets: 0, logs: 0, sets: 0 }
    @gets = {}
    @sets = {}
    @hosts = {}
    @requests = []
    @verbose = Application.instance.verbose
  end
end
