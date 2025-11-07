# frozen_string_literal: true

require_relative "../utils/project"
require_relative "../utils/verbose"
require_relative "../report/report"
require_relative "dsl/all"
require_relative "config"
require_relative "close"
# require_relative "builtin/main"
require_relative "host"
require_relative "play"
require_relative "result/result"

class Case
  include DSL
  include Verbose

  # Updated by ExecuteManager
  attr_accessor :action, :result, :sessions, :conn_status
  # Readed by ExecuteManager
  attr_reader :id, :config, :uniques, :skip

  @@id = "01" # First case ID value

  def initialize(config)
    @config = Case::Config.new(
      local: config,
      global: Project.value[:global]
    )
    @groups = Project.value[:groups]

    @id = @@id
    @@id = @@id.next

    # Define Case Report
    @report = Report.new(@id)
    @report.output_dir = File.join("var", @config.global[:tt_testname])

    # Default configuration
    @skip = false
    @skip = get(:tt_skip) unless get(:tt_skip) == "NODATA"
    unless Project.value[:options]["case"].nil?
      @skip = true
      @skip = false if Project.value[:options]["case"].include? @id.to_i
    end
    @debug = Project.debug?
    @verbose = Project.value[:verbose]

    @tmpdir = File.join("var", @config.get(:tt_testname), "tmp", @id.to_s)
    # ensure_dir @tmpdir # REVISE: When we will need this? Samba?

    @unique_values = {}
    @result = Result.new
    @action_counter = 0
    @action = {
      id: 0,
      weight: 1.0,
      description: "No description!",
      groupname: nil
    }
    @uniques = []
    @sessions = {} # Store opened sessions for this case
    @conn_status = {}
    tempfile :default
  end

  def export(format)
    return if skip?

    @report.export format
  end

  def filename
    # called from: close_main_report
    @report.filename
  end

  def grade
    return 0.0 if skip

    @report.tail[:grade]
  end

  def members
    return "-" if skip

    @report.head[:tt_members] || "noname"
  end

  alias_method :skip?, :skip
end
