require 'thor'
require_relative 'application'
require_relative 'project/project'
require_relative 'command/main'

# Command Line User Interface
class TeutonCommand < Thor
  map ['h', '-h', '--help'] => 'help'

  def method_missing(method, *_args, &_block)
    play(method.to_s)
  end

  def respond_to_missing?(method_name, include_private = false)
    super
  end
end
