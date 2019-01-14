
require_relative 'application'
require_relative 'tool'

#def task(name, &block)
#  Application.instance.tasks << { name: name, block: block }
#end

def group(name, &block)
#  task(name, &block)
  Application.instance.tasks << { name: name, block: block }
end
alias task group

def play(&block)
  Tool.instance.play(&block)
end
alias start play
