
require_relative '../application'
require_relative '../case_manager'

def group(name, &block)
  Application.instance.tasks << { name: name, block: block }
end
alias task group

def play(&block)
  CaseManager.instance.play(&block)
end
alias start play

# Development
def use(filename)
  app = Application.instance
  puts "__FILE__    " + __FILE__
  puts "filename    " + filename
  puts "script_path " + app.script_path
  puts "config_path " + app.config_path
  puts "test_name   " + app.test_name
end
