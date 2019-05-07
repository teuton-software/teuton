
require 'singleton'

require_relative 'application'
require_relative 'case'
require_relative 'report'
require_relative 'project/configfile_reader'
require_relative 'case_manager/check_cases'
require_relative 'case_manager/export'
require_relative 'case_manager/hall_of_fame'
require_relative 'case_manager/report'
require_relative 'case_manager/show'
require_relative 'case_manager/utils'

# This class does all the job
# Organize the hole job, sending orders to others classes
# * initialize
# * play
# Split into several files:
# * case_manager/check_cases
# * case_manager/export
# * case_manager/hall_of_fame
# * case_manager/report
# * case_manager/show

class CaseManager
  include Singleton
  include Utils

  def initialize
    #@tasks = []
    @cases = []
    @report = Report.new(0)
    @report.filename = 'resume'
  end

  def play(&block)
    check_cases!
    instance_eval(&block)
    # Run export if user pass option command "--export=json"
    app = Application.instance
    unless app.options['export'].nil?
      export(:format => app.options['export'].to_sym)
    end
  end

  def send(args = {})
    threads = []
    puts ''
    puts '[INFO] Sending files...'
    puts args.to_s
    @cases.each { |c| threads << Thread.new { c.send(args) } }
    threads.each(&:join)
  end

end
