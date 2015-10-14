# encoding: utf-8

require 'singleton'
require 'yaml'

require_relative 'builder'
require_relative 'case'
require_relative 'utils'
require_relative 'report/report'

class Checker
  include Singleton
  include Utils
  include Builder
  
  attr_reader :global, :tests
	
  def initialize
    @global = {}
	@tests=[]
	@cases = []		
    @report = Report.new(0)
    @report.filename="resume"
	@debug = false
	@verbose = true
  end
		
  def check_cases!(pConfigFilename = File.join(File.dirname($0),File.basename($0,".rb")+".yaml") )
	#Load configurations from yaml file
	configdata = YAML::load(File.open(pConfigFilename))
	@global = configdata[:global] || {}
	@global[:tt_testname]= @global[:tt_testname] || File.basename($0,".rb")
	@global[:tt_sequence]=false if @global[:tt_sequence].nil? 
	@caseConfigList = configdata[:cases]

	#Create out dir
	@outdir = @global[:tt_outdir] || File.join("var",@global[:tt_testname],"out")
	ensure_dir @outdir
	@report.outdir=@outdir

	#Fill report head
    open_main_report(pConfigFilename)

	@caseConfigList.each { |lCaseConfig| @cases << Case.new(lCaseConfig) } # create cases
	start_time = Time.now
	if @global[:tt_sequence] then
		verboseln "[INFO] Running in sequence (#{start_time.to_s})"
		@cases.each { |c| c.start } # Process every case in sequence
	else
		verboseln "[INFO] Running in parallel (#{start_time.to_s})"
		threads=[]
		@cases.each { |c| threads << Thread.new{c.start} } # Process cases in parallel
		threads.each { |t| t.join }
	end
		
	# Collect "unique" values from all cases
	uniques={}
	@cases.each do |c|
      c.uniques.each do |key|
	    if uniques[key].nil? then
		  uniques[key]=[ c.id ]
	    else
		  uniques[key] << c.id
	    end
	  end
	end

	# Close reports for all cases
	threads=[]
	@cases.each { |c| threads << Thread.new{c.close uniques} }
	threads.each { |t| t.join }
		
	close_main_report(start_time)
  end
		
	def is_debug?
		@debug
	end
	
	def is_verbose?
		@verbose
	end

	def define_test(name, &block)
		@tests << { :name => name, :block => block }
	end
	
	def start(&block)
		check_cases!
		instance_eval &block
	end
	
	def show(mode=:resume)
		if mode==:resume or mode==:all then
			@report.show
		end
		if mode==:details or mode==:all then
			@cases.each { |c| puts "____"; c.report.show }
			puts "."
		end
	end
	
	def export(mode=:all, pArgs={})
		format= pArgs[:format] || :txt
		if mode==:resume or mode==:all then
			@report.export format
		end
		if mode==:details or mode==:all then
			threads=[]
			@cases.each { |c| threads << Thread.new{ c.report.export format } }
			threads.each { |t| t.join }
		end
	end

  def build( app, pArgs={})
	case app
	when :gamelist
	  build_game_list pArgs
	end
  end
	
private

  def close_main_report(start_time)
    finish_time=Time.now
    @report.tail[:start_time]=start_time
    @report.tail[:finish_time]=finish_time
    @report.tail[:duration]=finish_time-start_time
    
    verboseln "\n[INFO] Duration = #{(finish_time-start_time).to_s} (#{finish_time.to_s})"
    verboseln "\n"
    verboseln "="*@report.head[:tt_title].length

	@cases.each do |c|
      lMembers=c.report.head[:tt_members] || 'noname'
      lGrade=c.report.tail[:grade] || 0.0
      lHelp=" "
      lHelp="?" if lGrade<50.0
      lHelp="*" if lGrade==100.0
			
	  @report.lines << "Case_"+"%03d"%c.id.to_i+" => "+"%3d"%lGrade.to_f+" #{lHelp} #{lMembers}"
	end
  end

  def open_main_report(pConfigFilename)
 	@report.head[:tt_title]="Executing tt-checker tests (version 0.3)"
	@report.head[:tt_scriptname]=$0
	@report.head[:tt_configfile]=pConfigFilename
	@report.head[:tt_debug]=true if @debug
	@report.head.merge!(@global)
		
	execute('clear')
	verboseln "="*@report.head[:tt_title].length
    verboseln @report.head[:tt_title]
  end
  
end

