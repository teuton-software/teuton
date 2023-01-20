require "rainbow"
require "singleton"
require_relative "../application"
require_relative "../report/report"
require_relative "../report/show"
require_relative "../utils/configfile_reader"
require_relative "case/case"
require_relative "export_manager"
require_relative "main"

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
  include Singleton
  include Utils
  attr_reader :report, :cases

  def initialize
    @cases = []
    @report = Report.new(0)
    @report.filename = "resume"
  end

  ##
  # Execute "play" order: Start every single case test
  # @param block (Block)
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

  ##
  # Execute "export" order: Export every case report
  # @param args (Hash) Export options
  def export(args = {})
    if args.class != Hash
      puts Rainbow("[ERROR] Argument error with 'export'!").red
      puts Rainbow("  Code : CaseManager#export").red
      puts Rainbow("  Line : export #{args}").red
      puts Rainbow("  Use  : export format: 'txt'").red
      puts ""
      exit 1
    end
    ExportManager.run(@report, @cases, args)
  end

  ##
  # Execute "send" order: Send every case report
  # @param args (Hash) Send options
  def send(args = {})
    threads = []
    puts ""
    # puts Rainbow("-" * 50).green
    puts Rainbow("[INFO] Sending files...#{args}").color(:green)
    @cases.each { |c| threads << Thread.new { c.send(args) } }
    threads.each(&:join)
    puts Rainbow("[INFO] Finished").color(:green)
    # puts Rainbow("-" * 50).green
  end

  def show(options = {verbose: 1})
    verbose = options[:verbose]
    ShowReport.new(@report).call(verbose)
  end
end
