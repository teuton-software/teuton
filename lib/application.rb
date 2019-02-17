require 'singleton'

# This Singleton contains application params
class Application
  include Singleton

  attr_reader   :version, :letter, :output_basedir
  attr_reader   :default
  attr_reader   :running_basedir
  attr_accessor :verbose
  attr_accessor :options
  attr_accessor :global, :tasks, :hall_of_fame
  attr_accessor :script_path, :config_path, :test_name

  def initialize
    reset
  end

  def reset
    @version = '19.02.2'
    @letter = { good: '.', bad: 'F', error: '?', none: ' ' }
    @running_basedir = Dir.getwd
    @output_basedir = 'var'
    @default = { name: 'teuton', format: :txt, debug: false }
    @options = {}
    @verbose = true

    @global = {}
    @tasks = []
    @hall_of_fame = []
  end

  def debug
    @default[:debug]
  end

  def name
    @default[:name]
  end
end
