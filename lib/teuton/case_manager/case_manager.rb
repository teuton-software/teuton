# frozen_string_literal: true

require 'singleton'
require_relative '../application'
require_relative '../report/report'
require_relative '../project/configfile_reader'
require_relative 'case/case'
require_relative 'export_manager'
require_relative 'main'
require_relative 'utils'

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
    @cases = []
    @report = Report.new(0)
    @report.filename = 'resume'
  end

  def play(&block)
    check_cases!
    instance_eval(&block)
    # Run export if user pass option command "--export=json"
    i = Application.instance.options['export']
    export(format: i.to_sym) unless i.nil?
    # Accept "configfile" param REVISE There exists?
    i = Application.instance.options['configfile']
    export(format: i.to_sym) unless i.nil?
  end

  def export(args = {})
    if args.class != Hash
      puts "[ERROR] CaseManager#export: Argument = <#{args}>, " \
           "class = #{args.class}"
      puts '        Usage: export :format => :colored_text'
      raise '[ERROR] CaseManager#export: Argument error!'
    end
    ExportManager.run(@report, @cases, args)
    preserve_files if args[:preserve] == true
  end

  def preserve_files
    app = Application.instance
    t = Time.now
    subdir = "#{t.year}#{format('%02d',t.month)}#{format('%02d',t.day)}-" \
             "#{format('%02d',t.hour)}#{format('%02d',t.min)}" \
             "#{format('%02d',t.sec)}"
    logdir = File.join(app.output_basedir, app.global[:tt_testname], subdir)
    srcdir = File.join(app.output_basedir, app.global[:tt_testname])
    puts "[INFO] Preserving files => #{logdir}"
    FileUtils.mkdir(logdir)
    Dir.glob(srcdir, '**.*').each { |file| FileUtils.cp(file, logdir) }
  end

  def send(args = {})
    threads = []
    puts ''
    puts "[INFO] Sending files...#{args.to_s}"
    @cases.each { |c| threads << Thread.new { c.send(args) } }
    threads.each(&:join)
  end
end
