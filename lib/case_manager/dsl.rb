require_relative '../application'
require_relative 'case_manager'

def group(name, &block)
  Application.instance.groups << { name: name, block: block }
end
alias task group

def play(&block)
  CaseManager.instance.play(&block)
end
alias start play

# Development
def use(filename)
  @use = @use || []
  filename += '.rb'
  puts "[INFO] use #{filename}"
  app = Application.instance
  rootbase = File.dirname(app.script_path)

  rbfiles = File.join(rootbase, "**", filename)
  files = Dir.glob(rbfiles)
  files.sort.each { |f| @use << f if f.include?(filename) }
  @use
end
