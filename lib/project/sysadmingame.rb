
require_relative '../application'
require_relative '../tool'

def group(name, &block)
  Application.instance.tasks << { name: name, block: block }
end
alias task group

def play(&block)
  Tool.instance.play(&block)
end
alias start play
