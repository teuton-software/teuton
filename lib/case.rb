#!/usr/bin/ruby
# encoding: utf-8

require 'net/ssh'
require 'net/sftp'
require_relative 'result'
require_relative 'utils'

class Case
	include Utils
	attr_accessor :result

	def initialize(pTeacher, pConfig)
		@teacher=pTeacher
		@global=@teacher.global
		@config=pConfig
				
		#Define Report datagroup
		@datagroup = @teacher.report.new_datagroup
		@datagroup.head.merge! @config
		@datagroup.tail[:unique_fault]=0
		@caseId = @datagroup.order

		#Default configuration
		@config[:tt_skip] = @config[:tt_skip] || false
		@mntdir = "var/mnt/#{ @global[:tt_testname] }/#{@caseId.to_s}"
		@tmpdir = "var/tmp/#{ @global[:tt_testname] }/#{@caseId.to_s}"
		@remote_tmpdir = '/tmp'

		ensure_dir @mntdir
		ensure_dir @tmpdir

		@unique_values={}
		@result = Result.new
		@result.reset

		@debug=@teacher.is_debug?
		@verbose=@teacher.is_verbose?
	
		@action_counter=0		
		@action={ :id => 0, :weight => 1.0, :description => 'Empty description!'}

		verboseln "\nStarting case <"+get(:tt_members)+">"
	end

	def process	
		lbSkip=@config[:tt_skip]||false
		if lbSkip==true then
			verbose "Skipping case <"+@config[:tt_members]+">\n"
			return false
		end

		execute("rm #{@tmpdir}/*.tmp") #Detele previous temp files

		laTest=[]
		public_methods.sort.each { |m| laTest << m.to_s if m.to_s[0..3]=='test' }
		
		laTest.sort.each do |m| 
			verbose "* Processing <"+m+"> "
			public_send m 
			verbose "\n"
		end
		#@report.datagroup.close
		verboseln "\n"
	end

	#Set command 
	def command(pCommand, pArgs={})
		@action[:command]=pCommand
		if pArgs[:tempfile] then
			@action[:tempfile]=pArgs[:tempfile]
		else
			@action[:tempfile]='tempfile.tmp' 
		end
	end
	
	#Set description
	def description(pDescription)
		desc pDescription
	end
	
	def desc(pDescription)
		@action[:description]=pDescription
	end
	
	#Read param pOption from config or global Hash data
	def get(pOption)
		return @config[pOption] if @config[pOption]
		return @global[pOption] if @global[pOption]
		return nil
	end
	
	#Write this to de statement
	def info(pText)
	end

	def path_to_tempfile
		lsTempfile = tempfile
		
		if lsTempfile.split("/")[0]!=@tmpdir then
			lsLocalfile = @tmpdir+"/"+lsTempfile
		else
			lsLocalfile = lsTempfile
		end
		return lsLocalfile
	end
	
	#Set weight value for the action
	def weight(pValue=1.0)
		@action[:weight]=pValue.to_f
	end
	
	#Run command from the host identify as pHostname
	def run_on(pHostname=:localhost)
		if pHostname==:localhost || pHostname.to_s.include?('127.0.0.') then
			run_local_cmd
		else
			key=( (pHostname.to_s.split('_')[0])+'_ip' ).to_sym
			lsIP=get( key )
			if lsIP.include?('127.0.0.') then
				run_local_cmd
			else
				run_remote_cmd pHostname
			end
		end
	end

	#Si se cumple la condición, entonces se registra el evento como un acierto.
	#En caso contrario se registra como un error.	
	def check(pCond, pArgs={})
		@action[:weight]=pArgs[:weight].to_f if pArgs[:weight]
		lWeight= @action[:weight]

		@action_counter+=1
		@action[:id]=@action_counter
		@action[:weight]=lWeight
		@action[:check]=pCond
		@datagroup.lines << @action.clone

		c="?"
		c="." if pCond
		verbose c
	end
	
	def log(pText, pType=:info)
		s="INFO: "
		s="WARN: " if pType==:warn
		s="ERROR: " if pType==:error
		@datagroup.lines << s+pText
	end
			
	def unique(psKey, psValue="")
		if @unique_values[psKey]==nil then
			@unique_values[psKey]=psValue
		else
			@datagroup.tail[:unique_fault]+=1
			log("Unique value (#{psKey}): #{psValue}",:error)
		end
	end
	
	def tempfile
		@action[:tempfile]
	end

private

	#Se devuelve el contenido del fichero indicado en los parámetros de entrada.
	def read_filename(psFilename)
		begin
			lFile = File.open(psFilename,'r')
			lItem = lFile.readlines
			lFile.close
			
			lItem.map! { |i| i.sub(/\n/,"") }
			
			return lItem
		rescue
			return []
		end
	end
	
	#Ejecuta un comando en local, guarda la salida en un fichero temporal.
	#
	#A continuación se lee el fichero de salida y se devuelve el contenido leído.
	def run_local_cmd
		lsCmd=@action[:command]
		lsTempfile= tempfile
		
		if lsTempfile.split("/")[0]!=@tmpdir then
			lsLocalfile = @tmpdir+"/"+lsTempfile
		else
			lsLocalfile = lsTempfile
		end
		lsCmd = lsCmd+' > ' + lsLocalfile
		execute(lsCmd)
		@result.content= read_filename(lsLocalfile)	
	end
	
	#Ejecuta un comando en maquina remota a través de SSH.
	def run_remote_cmd(pHostname) 
		lsCmd=@action[:command]
		lsTempfile=@action[:tempfile] || "tt_remote.tmp"
		
		hostname=pHostname.to_s
		lsIP=get((hostname+'_ip').to_sym)
		lsUsername=get((hostname+'_username').to_sym)
		lsPassword=get((hostname+'_password').to_sym)

		lsRemotefile = @remote_tmpdir+"/"+lsTempfile
		lsLocalfile = @tmpdir+"/"+lsTempfile
		
		lsCmd=lsCmd+" > "+lsRemotefile
		
		begin
			lsText="SSH on <#{lsUsername}@#{lsIP}> exec: "+lsCmd
			Net::SSH.start(lsIP, lsUsername, :password => lsPassword) {|ssh| ssh.exec(lsCmd) }

			lsText="SFTP downloading <#{lsIP}:#{lsRemotefile}>"
			Net::SFTP.start(lsIP, lsUsername, :password => lsPassword) { |sftp| sftp.download!(lsRemotefile, lsLocalfile) }
		rescue
			verbose "!"
			log(lsText) #, :error)
		end
		
		@result.content=read_filename(lsLocalfile)
	end
end
