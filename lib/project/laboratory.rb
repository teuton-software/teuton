require 'terminal-table'
require 'rainbow'

require_relative '../application'
require_relative '../case_manager/case/result'
require_relative 'configfile_reader'
require_relative 'laboratory/show'
require_relative 'laboratory/dsl'

def group(name, &block)
  Application.instance.groups << { name: name, block: block }
end
alias task group

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
