require_relative '../application'
require_relative 'case_manager'

def use(filename)
  filename += '.rb'
  app = Application.instance
  rbfiles = File.join(app.project_path, "**", filename)
  files = Dir.glob(rbfiles)
  findfiles = []
  files.sort.each { |f| findfiles << f if f.include?(filename) }
  require_relative findfiles.first
  app.uses << File.basename(findfiles.first)
end

def define_check(name, *args, &block)
  Application.instance.checks[name] = { args: args, block: block }
end
alias definecheck define_check
alias def_check define_check
alias defcheck define_check
alias dcheck define_check

def group(name, &block)
  Application.instance.groups << { name: name, block: block }
end
alias task group

def play(&block)
  CaseManager.instance.play(&block)
end
alias start play
