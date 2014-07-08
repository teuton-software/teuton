#!/usr/bin/ruby
# encoding: utf-8

require 'rubygems'
require 'singleton'
require 'yaml'

require_relative 'case'
require_relative 'utils'
require_relative 'report/report'

class Checker
	include Singleton
	include Utils
	attr_reader :global, :tests
	
	def initialize
		@global = {}
		@report = Report.new(0)
		@report.filename="resume"
		@cases = []		
		@debug = false
		@verbose = true
		@tests=[]
	end
		
	def check_cases!(pConfigFilename = File.join(File.dirname($0),File.basename($0,".rb")+".yaml") )
		execute('clear')
		
		#Load cases from yaml config file
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
		@report.head[:tt_title]="Executing tt-checker tests (version 0.2)"
		@report.head[:tt_scriptname]=$0
		@report.head[:tt_configfile]=pConfigFilename
		@report.head[:tt_debug]=true if @debug
		@report.head.merge!(@global)
		
		bar = "="*@report.head[:tt_title].length
		verboseln bar
		verboseln @report.head[:tt_title]

		@caseConfigList.each { |lCaseConfig| @cases << Case.new(lCaseConfig) } # create cases
		start_time = Time.now
		if @global[:tt_sequence] then
			verboseln "[INFO] Running in sequence (#{start_time.to_s})"
			
			@cases.each { |c| c.start }
		else
			verboseln "[INFO] Running in parallel (#{start_time.to_s})"
			threads=[]
			@cases.each { |c| threads << Thread.new{c.start} }
			threads.each { |t| t.join }
		end
		finish_time=Time.now
		@report.tail[:start_time_]=start_time
		@report.tail[:finish_time]=finish_time
		@report.tail[:duration]=finish_time-start_time
		verboseln "\n[INFO] Duration = #{(finish_time-start_time).to_s} (#{finish_time.to_s})"

		verboseln "\n"
		verboseln bar
		
		close_main_report
	end
	
	def debug=(pValue)
		@debug=pValue
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
	
	def show(data=:resume)
		case data
		when :resume
			@report.show
		when :all
			@report.show
			@cases.each { |c| puts "____"; c.report.show }
			puts "."
		end
	end
	
	def export(data=:resume, pArgs={})
		format= pArgs[:format] || :txt
		case data
		when :resume
			@report.export format
		when :all
			@report.export format
			@cases.each { |c| c.report.export format }
		end
	end

private

	def close_main_report
		@cases.each do |c|
			lMembers=c.report.head[:tt_members] || 'noname'
			lGrade=c.report.tail[:grade] || 0.0
			lHelp=" "
			lHelp="?" if lGrade<50.0
			lHelp="*" if lGrade==100.0
			
			@report.lines << "Case #{c.id.to_s} #{lHelp} (#{lGrade.to_s}) #{lMembers}"
		end
	end

end

