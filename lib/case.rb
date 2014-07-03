#!/usr/bin/ruby
# encoding: utf-8

require 'net/ssh'
require 'net/sftp'
require_relative 'dsl'
require_relative 'result'
require_relative 'teacher'
require_relative 'utils'

class Case
	include DSL
	include Utils
	attr_accessor :result

	def initialize(pConfig)
		@teacher=Teacher.instance
		@global=@teacher.global
		@config=pConfig
		@tests=Teacher.instance.tests
				
		#Define Report datagroup
		@datagroup = @teacher.report.new_datagroup
		@datagroup.head.merge! @config
		@datagroup.tail[:unique_fault]=0
		@caseId = @datagroup.order

		#Default configuration
		@config[:tt_skip] = @config[:tt_skip] || false
		@mntdir = File.join( "var", "mnt", @global[:tt_testname], @caseId.to_s )
		@tmpdir = File.join( "var", "tmp", @global[:tt_testname], @caseId.to_s )
		@remote_tmpdir = File.join( "/", "tmp" )

		ensure_dir @mntdir
		ensure_dir @tmpdir

		@unique_values={}
		@result = Result.new
		@result.reset

		@debug=@teacher.is_debug?
		@verbose=@teacher.is_verbose?
	
		@action_counter=0		
		@action={ :id => 0, :weight => 1.0, :description => 'Empty description!'}
		tempfile :default
		
		verboseln "\nStarting case <"+get(:tt_members)+">"
	end

	def start
		lbSkip=@config[:tt_skip]||false
		if lbSkip==true then
			verbose "Skipping case <"+@config[:tt_members]+">\n"
			return false
		end

		r=`ls #{@tmpdir}/*.tmp | wc -l`
		if r[0].to_i>0 then
			execute("rm #{@tmpdir}/*.tmp") #Detele previous temp files
		end
		
		@tests.each do |t|
			verbose "* Processing <"+t[:name].to_s+"> "
			instance_eval &t[:block]
			verbose "\n"
		end
		
		@datagroup.close
		verboseln "\n"
	end

	#Read param pOption from config or global Hash data
	def get(pOption)
		return @config[pOption] if @config[pOption]
		return @global[pOption] if @global[pOption]
		return nil
	end

end
