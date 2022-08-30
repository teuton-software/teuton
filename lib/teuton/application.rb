# frozen_string_literal: true

require 'singleton'
require_relative 'version'
require_relative 'utils/name_file_finder'

# This Singleton contains application params
class Application
  include Singleton
  include Teuton

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

  def initialize
    reset
  end

  def reset
    @letter = { good: '.', bad: 'F', error: '?', none: ' ',
                ok: "\u{2714}", cross: "\u{2716}" }
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

  ##
  # Preprocess input options:
  # * Convert input case options String to an Array of integers
  # * Read color input option
  def add_input_params(projectpath, options)
    @options.merge! options
    NameFileFinder.find_filenames_for(projectpath)
    @options['color'] = true if @options['color'].nil?
    Rainbow.enabled = @options['color']
    @options['panel'] = false if @options['panel'].nil?

    return if @options['case'].nil?

    a = @options['case'].split(',')
    @options['case'] = a.collect!(&:to_i)
  end
end
