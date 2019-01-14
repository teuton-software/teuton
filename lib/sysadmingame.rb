
require_relative 'application'
require_relative 'tool'

def task(name, &block)
  Application.instance.tasks << { name: name, block: block }
end

def group(name, &block)
  task(name, &block)
end

def play(&block)
  Tool.instance.start(&block)
end
alias start play
