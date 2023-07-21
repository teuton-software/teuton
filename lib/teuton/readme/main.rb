require_relative "../utils/project"
require_relative "readme"

def use(filename)
  filename += ".rb"
  rbfiles = File.join(Project.value[:project_path], "**", filename)
  files = Dir.glob(rbfiles)
  use = []
  files.sort.each { |f| use << f if f.include?(filename) }
  require_relative use[0]
  Project.value[:uses] << use[0]
end

def define_macro(name, *args, &block)
  Project.value[:macros][name] = {args: args, block: block}
end

def group(name, &block)
  Project.value[:groups] << {name: name, block: block}
end
alias task group

def start(&block)
  # don't do nothing
end
# alias_method "play", "start" # REVISE THIS
alias play start
