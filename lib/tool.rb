# encoding: utf-8

require 'singleton'

require_relative 'application'
require_relative 'configfile_reader'
require_relative 'case/case'
require_relative 'utils'
require_relative 'report'

# This class does all the job
# Organize the hole job, sending orders to others classes
class Tool
  include Singleton
  include Utils

  def initialize
    @tasks = []
    @cases = []
    @report = Report.new(0)
    @report.filename = 'resume'
    @app = Application.instance
  end

  def start(&block)
    check_cases!
    instance_eval(&block)
  end

  def check_cases!
	  # Load configurations from yaml file
    configdata = ConfigFileReader.read(@app.config_path)
	  @app.global = configdata[:global] || {}
    @app.global[:tt_testname] = @app.global[:tt_testname] || @app.test_name
	  @app.global[:tt_sequence] = false if @app.global[:tt_sequence].nil?
    @caseConfigList = configdata[:cases]

    # Create out dir
    @outdir = @app.global[:tt_outdir] || File.join('var',@app.global[:tt_testname], 'out')
    ensure_dir @outdir
    @report.output_dir = @outdir

    # Fill report head
    open_main_report(@app.config_path)

    # create cases
    @caseConfigList.each { |lCaseConfig| @cases << Case.new(lCaseConfig) }
    start_time = Time.now
    if @app.global[:tt_sequence]
      verboseln "[INFO] Running in sequence (#{start_time})"
      @cases.each(&:start) # Process every case in sequence
    else
      verboseln "[INFO] Running in parallel (#{start_time})"
      threads = []
      @cases.each { |c| threads << Thread.new{ c.start } } # Process cases run in parallel
      threads.each(&:join)
    end

    # Collect "unique" values from all cases
    uniques = {}
    @cases.each do |c|
      c.uniques.each do |key|
        if uniques[key].nil?
          uniques[key] = [c.id]
        else
          uniques[key] << c.id
        end
      end
    end

    # Close reports for all cases
    threads = []
    @cases.each { |c| threads << Thread.new { c.close uniques } }
    threads.each(&:join)

    # Build Hall of Fame
    @app.hall_of_fame = build_hall_of_fame

    close_main_report(start_time)
  end

  def show(mode = :resume)
    @report.show if mode == :resume || mode == :all
    if mode == :details || mode == :all
      @cases.each { |c| puts '____'; c.report.show }
      puts '.'
    end
  end

  def export(args = {})
    if args.class != Hash
      puts "[ERROR] export Argument = #{args}, class = #{args.class}"
      raise 'export Arguments are incorrect'
    end
    # default :mode=>:all, :format=>:txt
    format = args[:format] || :txt

    mode = args[:mode] || :all
    @report.export format if mode == :resume || mode == :all

    if mode == :details || mode == :all
      threads = []
      @cases.each { |c| threads << Thread.new { c.report.export format } }
      threads.each(&:join)
    end
  end

  def send(args = {})
    threads = []
    puts ''
    puts '[INFO] Sending files...'
    @cases.each { |c| threads << Thread.new { c.send args } }
    threads.each(&:join)
  end

  private

  def build_hall_of_fame
    celebrities = {}

    @cases.each do |c|
      grade = c.report.tail[:grade]
      if celebrities[grade]
        label = celebrities[grade] + '*'
      else
        label = '*'
      end
      celebrities[grade] = label unless c.skip
    end

    a = celebrities.sort_by { |key, _value| key }
    list = a.reverse
    list
  end

  def open_main_report(p_config_filename)
    app = Application.instance

    @report.head[:tt_title] = "Executing [#{app.name}] (version #{app.version})"
    @report.head[:tt_scriptname] = app.script_path
    @report.head[:tt_configfile] = p_config_filename
    @report.head[:tt_debug] = true if @debug
    @report.head.merge!(app.global)

    my_execute('clear')
    verboseln '=' * @report.head[:tt_title].length
    verboseln @report.head[:tt_title]
  end

  def close_main_report(start_time)
    finish_time = Time.now
    @report.tail[:start_time] = start_time
    @report.tail[:finish_time] = finish_time
    @report.tail[:duration] = finish_time - start_time

    verboseln "\n[INFO] Duration = #{(finish_time - start_time)} (#{finish_time})"
    verboseln "\n"
    verboseln '=' * @report.head[:tt_title].length

    app = Application.instance
    @cases.each do |c|
      l_members = c.report.head[:tt_members] || 'noname'
      l_grade = c.report.tail[:grade] || 0.0
      l_help = app.letter[:none]
      l_help = app.letter[:error] if l_grade < 50.0
      # t = 'Case_' + "%02d" % c.id.to_i + ' => '
      t = format('Case_%02d => ', c.id.to_i)
      # t = t + "%3d" % l_grade.to_f + " #{l_help} #{l_members}"
      t += format('%3d %s %s', l_grade.to_f, l_help, l_members)
      @report.lines << t
    end
  end
end
