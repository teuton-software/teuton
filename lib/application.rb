require 'singleton'

# This Singleton contains application params
class Application
  include Singleton

  attr_reader   :version, :letter
  attr_reader   :running_basedir, :output_basedir
  attr_reader   :default
  attr_accessor :options
  attr_accessor :verbose
  attr_accessor :global, :groups, :uses, :hall_of_fame
  attr_accessor :project_path, :script_path, :config_path, :test_name

  def initialize
    reset
  end

  def reset
    @version = '2.0.5'
    @letter = { good: '.', bad: 'F', error: '?', none: ' ' }
    @running_basedir = Dir.getwd
    @output_basedir = 'var'
    @default = { name: 'teuton', format: :txt, debug: false }
    @options = {}
    @verbose = true

    @global = {}
    @groups = []
    @uses = [] # TODO
    @hall_of_fame = []
  end

  def debug
    @default[:debug]
  end

  def name
    @default[:name]
  end
end
