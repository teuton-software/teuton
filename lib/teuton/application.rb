require 'singleton'

# This Singleton contains application params
class Application
  include Singleton

  VERSION = '2.1.1' # Application version
  NAME = 'teuton'   # Application name

  attr_reader   :letter
  attr_reader   :running_basedir, :output_basedir
  attr_reader   :default
  attr_accessor :options
  attr_accessor :verbose
  attr_accessor :global, :ialias
  attr_accessor :checks, :groups, :uses
  attr_accessor :hall_of_fame
  attr_accessor :project_path, :script_path, :config_path, :test_name

  def initialize
    reset
  end

  def reset
    @letter = { good: '.', bad: 'F', error: '?', none: ' ' }
    @running_basedir = Dir.getwd
    @output_basedir = 'var'
    @default = { name: 'teuton', format: :txt, debug: false }
    @options = { 'lang' => 'en' }
    @verbose = true

    @global = {}
    @ialias = {}
    @checks = {}
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

  def quiet?
    return true if Application.instance.options['quiet']
    return true unless Application.instance.verbose
    false
  end
end
