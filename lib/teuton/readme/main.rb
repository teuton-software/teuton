require_relative "../utils/project"
require_relative "readme"

def use(filename)
  filename += ".rb"
  rbfiles = File.join(Project.value[:project_path], "**", filename)
  files = Dir.glob(rbfiles)
  use = []
  files.sort.each { |f| use << f if f.include?(filename) }
  require_relative use.first
  Project.value[:uses] << use.first
end

def define_macro(name, *args, &block)
  Project.value[:macros][name] = { args: args, block: block }
end

def group(name, &block)
  Project.value[:groups] << { name: name, block: block }
end

def task(...)
  Logger.warn "[DEPRECATED] Replace 'task' by 'group'"
  group(...)
end

def play(&block)
  # don't do nothing
end

def start(...)
  Logger.warn "[DEPRECATED] Replace `start' by' play'"
  play(...)
end
