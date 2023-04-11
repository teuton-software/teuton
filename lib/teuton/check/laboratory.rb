# frozen_string_literal: true

require_relative "../utils/project"
require_relative "../utils/result/result"
require_relative "show"
require_relative "dsl"
require_relative "builtin"

def use(filename)
  filename += ".rb"
  rbfiles = File.join(Project.value[:project_path], "**", filename)
  files = Dir.glob(rbfiles)
  use = []
  files.sort.each { |f| use << f if f.include?(filename) }
  require_relative use[0]
  Project.value[:uses] << use[0]
end

def group(name, &block)
  Project.value[:groups] << {name: name, block: block}
end
alias task group

def define_macro(name, *args, &block)
  Project.value[:macros][name] = {args: args, block: block}
end
alias def_macro define_macro
alias defmacro define_macro


def start(&block)
  # Don't do nothing. We are checking test not running it
end
alias play start

# Show objectives stats from RB script file
class Laboratory
  attr_reader :result

  def initialize(script_path, config_path)
    @path = {}
    @path[:script] = script_path
    @path[:dirname] = File.dirname(script_path)
    @path[:filename] = File.basename(script_path, ".rb")
    @path[:config] = config_path
    reset
  end

  def reset
    @result = Result.new
    @targetid = 0
    @stats = {groups: 0, targets: 0, uniques: 0, gets: 0, logs: 0, sets: 0}
    @gets = {}
    @sets = {}
    @hosts = {}
    @requests = [] # REVISE this
    @verbose = Project.value[:verbose]
  end
end
