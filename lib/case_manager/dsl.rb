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

def group(name, &block)
  Application.instance.groups << { name: name, block: block }
end
alias task group

def play(&block)
  CaseManager.instance.play(&block)
end
alias start play
