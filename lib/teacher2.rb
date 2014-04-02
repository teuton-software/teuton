#!/usr/bin/ruby
# encoding: utf-8

require 'rubygems'
require 'net/ssh'
require 'net/sftp'
require 'yaml'

require_relative 'case'
require_relative 'utils'
require_relative 'report/report2'

class Teacher
	include Utils
	attr_reader :global, :report 
	
	def initialize
		@global = {}
		@report = Report.new
		@cases = []		
		@debug = false
		@verbose = true
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
		
	def checkit!(pConfigFilename="."+$0.split(".")[1]+".yaml")
		execute('clear')
		
		#Load cases from yaml config file
		configdata = YAML::load(File.open(pConfigFilename))
		@global = configdata[:global] || {}
		@global[:tt_testname]=($0.split(".")[1]).split("/").last if !@global[:tt_testname]
		@caseConfigList = configdata[:cases]

		#Create out dir
		@outdir = @global[:tt_outdir] || "var/out/#{@global[:tt_testname]}"
		ensure_dir @outdir
		@report.outdir=@outdir

		#Fill report head
		@report.head[:tt_title]="Executing Teacher tests (version 1)"
		@report.head[:tt_scriptname]=$0
		@report.head[:tt_configfile]=pConfigFilename
		@report.head[:tt_debug]=true if @debug
		@report.head[:tt_start_time_]=Time.new.to_s
		@report.head.merge!(@global)
		
		verboseln "="*@report.head[:tt_title].length
		verboseln @report.head[:tt_title]

		@caseConfigList.each do |lCaseConfig|
			c = Case.new(self, lCaseConfig)
			c.process
		end
		verboseln "\n"
		verboseln "="*@report.head[:tt_title].length
		
		@report.close
	end

end
