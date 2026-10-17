# frozen_string_literal: true

require_relative "../utils/project"
require_relative "../utils/verbose"
require_relative "../report/report"
require_relative "dsl/all"
require_relative "action/action"
require_relative "action/manager"
require_relative "config"
require_relative "close"
# require_relative "builtin/main"
require_relative "host"
require_relative "play"
require_relative "result/result"

class Case
  include DSL
  include Verbose

  # INFO: Used by ExecuteManager
  attr_accessor :action, :result, :sessions, :conn_status
  attr_reader :id, :config, :uniques, :skip

  @current_case_id = Project.value[:base_case_id]

  def self.next_id
    @current_case_id = @current_case_id.next
  end

  def initialize(config)
    @config = Case::Config.new(
      local: config,
      global: Project.value[:global]
    )
    @id = Case.next_id
    @groups = Project.value[:groups]
    @report = Report.new(@id)

    # Default configuration
    @skip = false
    @skip = get(:tt_skip) unless get(:tt_skip) == "NODATA"
    unless Project.value[:options]["case"].nil?
      @skip = true
      @skip = false if Project.value[:options]["case"].include? @id.to_i
    end
    @tempdir = File.join(Project.value[:output_dir], "tmp", @id.to_s)
    @verbose = Project.value[:verbose]

    @unique_values = {}
    @result = Result.new
    @action = Action.new
    @action_manager = ActionManager.new
    @uniques = []
    @sessions = {} # Store opened sessions for this case
    @conn_status = {}
  end

  def export(format)
    return if skip?

    @report.export format
  end

  def filename
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
