require_relative "../utils/project"
require_relative "case_manager"

# DSL instructions that apply to all cases. Stored globally in the case manager.
# * define_macro
# * group
# * play
# * use

def define_macro(name, *args, &block)
  Project.value[:macros][name] = { args: args, block: block }
end
alias def_macro define_macro
alias defmacro define_macro

def group(name, &block)
  Project.value[:groups] << { name: name, block: block }
end
alias task group

def play(&block)
  CaseManager.new.play(&block)
end

def start(...)
  Logger.warn "[DEPRECATED] Replace 'start do' by `play do'"
  play(...)
end

def use(filename)
  filename += ".rb"
  rbfiles = File.join(Project.value[:project_path], "**", filename)
  files = Dir.glob(rbfiles)
  findfiles = []
  files.sort.each { |f| findfiles << f if f.include?(filename) }
  begin
    require_relative findfiles.first
    Project.value[:uses] << File.basename(findfiles.first)
  rescue StandardError => e
    warn Rainbow("[ERROR] case_manager/dsl: #{e}").bright.red
    warn Rainbow("[ERROR] File not found!").white
    warn Rainbow("[ERROR] Fix line <use '#{filename}'>").white
    exit 1
  end
end
