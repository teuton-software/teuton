# encoding: utf-8

require 'singleton'

require_relative 'application'
require_relative 'configfile_reader'
require_relative 'case/case'
require_relative 'utils'
require_relative 'report'
require_relative 'case_manager/check_cases'
require_relative 'case_manager/export'
require_relative 'case_manager/hall_of_fame'
require_relative 'case_manager/report'
require_relative 'case_manager/show'

# This class does all the job
# Organize the hole job, sending orders to others classes
# * initialize
# * start
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
    @tasks = []
    @cases = []
    @report = Report.new(0)
    @report.filename = 'resume'
    @app = Application.instance
  end

  def play(&block)
    check_cases!
    instance_eval(&block)
  end

  def send(args = {})
    threads = []
    puts ''
    puts '[INFO] Sending files...'
    @cases.each { |c| threads << Thread.new { c.send args } }
    threads.each(&:join)
  end

end
