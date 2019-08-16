# frozen_string_literal: true

require_relative '../../application'
require_relative '../../report/report'
require_relative '../utils'
require_relative 'main'
require_relative 'result/result'
require_relative 'case_model/case_model'

# TODO: split Case class into several classes:
# * Case, Action?, Session?, RunCommand class

# Case class
# * initialize
# * skip
# * grade
# * members
# * export
# * show
# * read_filename ???
class Case
  include DSL
  include Utils

  attr_accessor :result
  attr_accessor :action # TODO: why not reader only???
  attr_reader :id, :config, :uniques
  @@id = 1

  def initialize(config)
    app = Application.instance
    @config = Case::Config.new(local: config, global: app.global)
    @groups = app.groups

    @id = @@id
    @@id += 1

    # Define Case Report
    @report = Report.new(@id)
    @report.output_dir = File.join('var', @config.global[:tt_testname])
    ensure_dir @report.output_dir

    # Default configuration
    @skip = false
    @skip = get(:tt_skip) unless get(:tt_skip) == 'NODATA'
    unless app.options['case'].nil?
      @skip = true
      @skip = false if app.options['case'].include? @id
    end

    @tmpdir = File.join('var', @config.get(:tt_testname), 'tmp', @id.to_s)
    # ensure_dir @tmpdir # REVISE: When we will need this? Samba?
    @remote_tmpdir = File.join('/', 'tmp')

    @unique_values = {}
    @result = Result.new

    @debug = Application.instance.debug
    @verbose = Application.instance.verbose

    @action_counter = 0
    @action = { id: 0,
                weight: 1.0,
                description: 'No description!',
                groupname: nil }
    @uniques = []
    @sessions = {} # Store opened sessions for this case
    tempfile :default
  end

  def skip
    @skip
  end
  alias skip? skip

  def grade
    return 0.0 if skip
    @report.tail[:grade]
  end

  def members
    return "-" if skip
    @report.head[:tt_members] || 'noname'
  end

  def export(format)
    return if skip?
    @report.export format
  end

  def show
    @report.show
  end

  private

  def read_filename(filename)
    begin
      file = File.open(filename, 'r')
      item = file.readlines
      file.close

      item.map! { |i| i.sub(/\n/, '') }

      return item
    rescue StandardError
      return []
    end
  end
end
