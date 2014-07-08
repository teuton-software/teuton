#!/usr/bin/ruby
# encoding: utf-8

require 'net/ssh'
require 'net/sftp'
require_relative 'checker'
require_relative 'dsl'
require_relative 'result'
require_relative 'utils'

class Case
	include DSL
	include Utils
	attr_accessor :result
	attr_reader :id, :report
	@@id=1

	def initialize(pConfig)
		@global=Checker.instance.global
		@config=pConfig
		@tests=Checker.instance.tests
		@id=@@id; @@id+=1
				
		#Define Case Report
		@report = Report.new(@id)
		@report.filename=( @id<10 ? "case-0#{@id.to_s}" : "case-#{@id.to_s}" )
		@report.outdir=File.join( "var", @global[:tt_testname], "out" )
		ensure_dir @report.outdir
		
		@report.head.merge! @config
		@report.tail[:case_id]=@id
		@report.tail[:unique_fault]=0

		#Default configuration
		@config[:tt_skip] = @config[:tt_skip] || false
		@mntdir = File.join( "var", @global[:tt_testname], "mnt", @id.to_s )
		@tmpdir = File.join( "var", @global[:tt_testname], "tmp", @id.to_s )
		@remote_tmpdir = File.join( "/", "tmp" )

		ensure_dir @mntdir
		ensure_dir @tmpdir

		@unique_values={}
		@result = Result.new
		@result.reset

		@debug=Checker.instance.is_debug?
		@verbose=Checker.instance.is_verbose?
	
		@action_counter=0		
		@action={ :id => 0, :weight => 1.0, :description => 'Empty description!'}
		tempfile :default
		
	end

	def start
		lbSkip=@config[:tt_skip]||false
		if lbSkip==true then
			verbose "Skipping case <"+@config[:tt_members]+">\n"
			return false
		end

		r=`ls #{@tmpdir}/*.tmp 2>/dev/null | wc -l`
		execute("rm #{@tmpdir}/*.tmp") if r[0].to_i>0 #Detele previous temp files
		
		if @global[:tt_sequence] then
			verboseln "\nStarting case <"+get(:tt_members)+">"
			@tests.each do |t|
				verbose "* Processing <"+t[:name].to_s+"> "
				instance_eval &t[:block]
				verbose "\n"
			end
			verboseln "\n"
		else
			@tests.each { |t| instance_eval &t[:block] }
		end
		
		@report.close_case
	end

end
