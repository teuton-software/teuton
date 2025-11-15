require_relative "../case/case"
require_relative "../report/report"
require_relative "../utils/project"
require_relative "../utils/verbose"
require_relative "../utils/configfile_reader"
require_relative "check_cases"
require_relative "export_manager"
require_relative "send_manager"
require_relative "show_report"
require_relative "stats_manager"
require_relative "report"
# require_relative "utils"

# * initialize
# * play
# Split into several files:
# * check_cases
# * export_manager
# * send_manager
# * show_report
class CaseManager
  # include Utils
  include Verbose

  attr_reader :report, :cases

  def initialize
    @cases = []
    @report = Report.new(0)
    @report.filename = "resume"
  end

  def play(&block)
    # Execute "play" order: Start every single case test
    check_cases!
    instance_eval(&block)
    # Run export if user pass option command "--export=FORMAT"
    i = Project.value[:options]["export"]
    export(format: i.to_sym) unless i.nil?
    # Accept "configfile" param REVISE There exists?
    i = Project.value[:options]["configfile"]
    export(format: i.to_sym) unless i.nil?
    # TODO: Export Stats
    StatsManager.new.call(@cases)
  end

  def export(args = {})
    ExportManager.new.call(
      @report,
      @cases,
      args,
      Project.value[:format]
    )
  end

  def send(args = {})
    SendManager.new.call(@cases, args)
  end

  def show(options = {verbose: 1})
    ShowReport.new(@report).call(options[:verbose])
  end
end
