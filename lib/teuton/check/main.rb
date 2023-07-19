# frozen_string_literal: true

require_relative "../utils/project"

def use(filename)
  filename += ".rb"
  rbfiles = File.join(Project.value[:project_path], "**", filename)
  files = Dir.glob(rbfiles)
  use = []
  files.sort.each { |f| use << f if f.include?(filename) }
  require_relative use[0]
  Project.value[:uses] << use[0]
end

def group(name, &block)
  Project.value[:groups] << {name: name, block: block}
end
alias task group

def define_macro(name, *args, &block)
  Project.value[:macros][name] = {args: args, block: block}
end
alias def_macro define_macro
alias defmacro define_macro

def start(&block)
  # Don't do nothing. We are checking test not running it
end
alias play start
