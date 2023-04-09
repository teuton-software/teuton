require_relative "../application"
require_relative "../case/case"
require_relative "../report/report"
require_relative "../utils/configfile_reader"
require_relative "export_manager"
require_relative "send_manager"
require_relative "show_report"
require_relative "check_cases"
require_relative "report"
require_relative "utils"

# This class does all the job
# Organize the hole job, sending orders to others classes
# * initialize
# * play
# Split into several files:
# * case_manager/check_cases
# * case_manager/export
# * case_manager/hall_of_fame
# * case_manager/report
class CaseManager
  include Utils
  attr_reader :report, :cases

  def initialize
    @cases = []
    @report = Report.new(0)
    @report.filename = "resume"
  end

  ##
  # Execute "play" order: Start every single case test
  def play(&block)
    check_cases!
    instance_eval(&block)
    # Run export if user pass option command "--export=json"
    i = Application.instance.options["export"]
    export(format: i.to_sym) unless i.nil?
    # Accept "configfile" param REVISE There exists?
    i = Application.instance.options["configfile"]
    export(format: i.to_sym) unless i.nil?
  end

  def export(args = {})
    ExportManager.new.call(@report, @cases, args)
  end

  def send(args = {})
    SendManager.new.call(@cases, args)
  end

  def show(options = {verbose: 1})
    ShowReport.new(@report).call(options[:verbose])
  end
end
