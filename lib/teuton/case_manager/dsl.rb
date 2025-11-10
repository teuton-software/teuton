require_relative "../utils/project"
require_relative "case_manager"

# DSL instructions that apply equally to all cases.
# Therefore, they are stored globally in the case manager.
# * define_macro
# * group
# * play
# * use

def define_macro(name, *args, &block)
  Project.value[:macros][name] = { args: args, block: block }
end
alias def_macro define_macro
alias defmacro define_macro

# Define a group of [target/run/expect]s
# @param name (String) Group name
# @param block (Block) Tests code
def group(name, &block)
  Project.value[:groups] << { name: name, block: block }
end
alias task group

def play(&block)
  # Start test
  CaseManager.new.play(&block)
end
alias start play

def use(filename)
  filename += ".rb"
  rbfiles = File.join(Project.value[:project_path], "**", filename)
  files = Dir.glob(rbfiles)
  findfiles = []
  files.sort.each { |f| findfiles << f if f.include?(filename) }
  begin
    require_relative findfiles.first
    Project.value[:uses] << File.basename(findfiles.first)
  rescue => e
    puts "[ERROR] #{e}:"
    puts "        File not found! Fix line <use '#{filename}'>"
    exit 1
  end
end
