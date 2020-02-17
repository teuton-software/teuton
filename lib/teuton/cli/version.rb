# frozen_string_literal: true

require 'rainbow'

# Class method Teuton#version
class CLI < Thor
  map ['v', '-v', '--version'] => 'version'
  desc 'version', 'Show the program version'
  ##
  # Display version 
  def version
    print Rainbow(Application::NAME).bright.blue
    puts  ' (version ' + Rainbow(Application::VERSION).green + ')'
  end
end
