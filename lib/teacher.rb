#!/usr/bin/ruby
# encoding: utf-8

require 'rubygems'
require 'singleton'
require 'yaml'

require_relative 'case'
require_relative 'utils'
require_relative 'report/report2'

class Teacher
	include Singleton
	include Utils
	attr_reader :global, :report, :tests
	
	def initialize
		@global = {}
		@report = Report.new
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
		@global[:tt_testname]=($0.split(".")[1]).split("/").last if !@global[:tt_testname]
		@caseConfigList = configdata[:cases]

		#Create out dir
		@outdir = @global[:tt_outdir] || "var/out/#{@global[:tt_testname]}"
		ensure_dir @outdir
		@report.outdir=@outdir

		#Fill report head
		@report.head[:tt_title]="Executing Teacher tests (version 2)"
		@report.head[:tt_scriptname]=$0
		@report.head[:tt_configfile]=pConfigFilename
		@report.head[:tt_debug]=true if @debug
		@report.head[:tt_start_time_]=Time.new.to_s
		@report.head.merge!(@global)
		
		verboseln "="*@report.head[:tt_title].length
		verboseln @report.head[:tt_title]

		@caseConfigList.each do |lCaseConfig|
			c = Case.new(lCaseConfig)
			c.start
			@cases << c
		end
		verboseln "\n"
		verboseln "="*@report.head[:tt_title].length
		
		@report.close
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
end


def define_test(name, &block)
	Teacher.instance.define_test(name, &block)
end

def start(&block)
	Teacher.instance.start(&block)
end

