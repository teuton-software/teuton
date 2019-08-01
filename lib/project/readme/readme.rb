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
    @data[:groups] = []
    @data[:play] = []
    @current_group = []
    @current = {}
  end
end
