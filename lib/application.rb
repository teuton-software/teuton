
require 'singleton'

# This Singleton contains application params
class Application
  include Singleton

  attr_reader   :name, :version, :letter, :output_basedir
  attr_reader   :debug
  attr_reader   :default
  attr_accessor :verbose
  attr_accessor :options
  attr_accessor :global, :tasks, :hall_of_fame
  attr_accessor :script_path, :config_path, :test_name
  attr_accessor :running_basedir

  def initialize
    reset
  end

  def reset
    @name = 'teuton'
    @version = '1.15.2'
    @letter = { good: '.', bad: 'F', error: '?', none: ' ' }
    @output_basedir = 'var'
    @debug = false
    @default = { :format => :txt }
    @options = {}
    @verbose = true

    @global = {}
    @tasks = []
    @hall_of_fame = []
  end
end
