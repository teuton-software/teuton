require 'thor'
require_relative 'teuton/application'
require_relative 'teuton/project/project'
require_relative 'teuton/command/main'

# Command Line User Interface
class Teuton < Thor
  map ['h', '-h', '--help'] => 'help'

  def method_missing(method, *_args, &_block)
    play(method.to_s)
  end

  def respond_to_missing?(method_name, include_private = false)
    super
  end
end
