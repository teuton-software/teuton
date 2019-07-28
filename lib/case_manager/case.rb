require_relative '../application'
require_relative '../report/report'
require_relative 'utils'
require_relative 'case/main'
require_relative 'case/case_model/case_model'

# TODO: split Case class into several classes:
# * Case, Action?, Session?, RunCommand class

# Case class
class Case
  include DSL
  include Utils

  attr_accessor :result
  attr_accessor :action # TODO: why not reader only???
  attr_reader :id, :config, :report, :uniques
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
    @config.local[:tt_skip] = @config.local[:tt_skip] || false
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
                group: nil
              }
    @uniques = []
    @sessions = {}
    tempfile :default
  end

  def skip
    @config.get(:tt_skip)
  end

  private

  def read_filename(filename)
    begin
      file = File.open(filename, 'r')
      item = file.readlines
      file.close

      item.map! { |i| i.sub(/\n/, '') }

      return item
    rescue
      return []
    end
  end
end
