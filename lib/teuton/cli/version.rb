# frozen_string_literal: true

# Class method Teuton#version
class CLI < Thor
  map ['v', '-v', '--version'] => 'version'
  desc 'version', 'Show the program version'
  ##
  # Display version
  def version
    puts "#{Application::NAME} (version #{Application::VERSION})"
  end
end
