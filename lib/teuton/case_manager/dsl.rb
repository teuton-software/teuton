require_relative "../application"
require_relative "case_manager"

# Define filename to be used into our test
# @param filename (String) Filename to be required
def use(filename)
  filename += ".rb"
  app = Application.instance
  rbfiles = File.join(app.project_path, "**", filename)
  files = Dir.glob(rbfiles)
  findfiles = []
  files.sort.each { |f| findfiles << f if f.include?(filename) }
  require_relative findfiles.first
  app.uses << File.basename(findfiles.first)
end

# Define macro. That's a name to predefined target-run-expect evaluation.
# @param name (String) macro name
# @param block (Block) macro code
def define_macro(name, *args, &block)
  Application.instance.macros[name] = {args: args, block: block}
end
alias def_macro define_macro
alias defmacro define_macro

# Define a group of tests
# @param name (String) Group name
# @param block (Block) Tests code
def group(name, &block)
  Application.instance.groups << {name: name, block: block}
end
alias task group

# Start test
# @param block (Block) Extra code executed at the end.
def play(&block)
  CaseManager.instance.play(&block)
end
alias start play
