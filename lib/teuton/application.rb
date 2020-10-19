# frozen_string_literal: true

require 'singleton'
require_relative 'project/name_file_finder'

# This Singleton contains application params
class Application
  include Singleton

  VERSION = '2.2.0' # Application version
  NAME = 'teuton' # Application name

  attr_reader   :letter
  attr_reader   :running_basedir, :output_basedir
  attr_reader   :default
  attr_accessor :options
  attr_accessor :verbose
  attr_accessor :global # Global configuration params
  attr_accessor :ialias # Internal alias
  attr_accessor :macros # Array of macros
  attr_accessor :groups # Array of groups
  attr_accessor :uses # Array of uses
  attr_accessor :hall_of_fame
  attr_accessor :project_path, :script_path, :config_path, :test_name

  ##
  # Initialize Application instance
  def initialize
    reset
  end

  ##
  # Reset param values
  # rubocop:disable Metrics/MethodLength
  def reset
    @letter = { good: '.', bad: 'F', error: '?', none: ' ' }
    @running_basedir = Dir.getwd
    @output_basedir = 'var'
    @default = { name: 'teuton', format: :txt, debug: false }
    @options = { 'lang' => 'en' }
    @verbose = true

    @global = {}
    @ialias = {}
    @macros = {}
    @groups = []
    @uses = [] # TODO
    @hall_of_fame = []
  end
  # rubocop:enable Metrics/MethodLength

  ##
  # Return debug param
  # @return Boolean
  def debug
    @default[:debug]
  end

  ##
  # Return name param
  # @return String
  def name
    @default[:name]
  end

  ##
  # Return quiet param
  # @return Boolean
  def quiet?
    return true if Application.instance.options['quiet']
    return true unless Application.instance.verbose

    false
  end

  ##
  # Preprocess input options:
  # * Convert input case options String to an Array of integers
  # * Read color input option
  def add_input_params(projectpath, options)
    NameFileFinder.find_filenames_for(projectpath)
    @options.merge! options
    @options['color'] = true if @options['color'].nil?
    Rainbow.enabled = @options['color']
    @options['panel'] = false if @options['panel'].nil?
    return if @options['case'].nil?

    a = @options['case'].split(',')
    @options['case'] = a.collect!(&:to_i)
  end
end
