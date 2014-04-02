#!/usr/bin/ruby
# encoding: utf-8

require 'rubygems'
require 'net/ssh'
require 'net/sftp'
require 'yaml'

require_relative 'report/report'
require_relative 'result'

=begin
Definición de la clase Teacher(v1), y sus métodos para realiar correciones automáticas.

 David Vargas Ruiz
 davidvargas.tenerife@gmail.com

Necesitaremos tener instaladas las siguientes gemas de ruby:
 sudo gem install net-ssh net-sftp

También necesitaremos las siguientes herramientas:
 sudo apt-get install nmap ssh
 
=end

class Teacher
	attr_accessor :debug, :verbose
	attr_reader :result, :report
	
	def initialize
		@mntdir='var/mnt'
		@tmpdirbase='var/tmp'
		@outdirbase='var/out'
		@remote_tmpdir='/tmp'
		@unique_values={}
		ensure_dir @mntdir
		ensure_dir @tmpdirbase
		ensure_dir @outdirbase

		@report = Report.new
		@result = Result.new

		@debug=false
		@verbose=true
	end
	
		
	#Este método tiene tres fases:
	# (a) Inicializa las variables de los test (método init)
	# (b) Ejecuta por orden alfabético los tests (métodos stepNN_XXX)
	# (c) y finalmente muestra los resultados en pantalla
	def process(pConfigFilename="."+$0.split(".")[1]+".yaml")
		execute('clear')
		
		laTest=[]
		public_methods.sort.each { |m| laTest << m.to_s if m.to_s[0..3]=='test' }

		#Load cases from yaml config file
		configdata = YAML::load(File.open(pConfigFilename))
		@global = configdata[:global]
		@global[:tt_testname]=($0.split(".")[1]).split("/").last if !@global[:tt_testname]
		@caselist = configdata[:cases]

		#Detele temp files
		@tmpdir="#{@tmpdirbase}/#{@global[:tt_testname]}" #-#{Time.new.strftime("%Y%m%d-%H%M")}"
		ensure_dir @tmpdir
		execute('rm '+@tmpdir+'/*.tmp') 
		@outdir="#{@outdirbase}/#{@global[:tt_testname]}"
		ensure_dir @outdir
		@report.outdir=@outdir

		#Fill report head
		@report.head[:tt_title]="Executing Teacher tests (version 1)"
		@report.head[:tt_scriptname]=$0
		@report.head[:tt_configfile]=pConfigFilename
		@report.head[:tt_start_time_]=Time.new.to_s
		@report.head[:tt_debug]=true if @debug
		@report.head.merge!(@global)
		
		verboseln "="*@report.head[:tt_title].length
		verboseln @report.head[:tt_title]

		@caselist.each do |lCase|
			if (start_new_case lCase) then
				laTest.sort.each do |m| 
					verbose("* Processing <"+m+"> ")
					public_send m 
					verbose("\n")
				end
				@report.datagroup.close
				verboseln "\n"
			end
		end
		verboseln "\n"
		verboseln "="*@report.head[:tt_title].length
		
		@report.close
	end
	
	def start_new_case(pCase)		
		lbSkip=pCase[:tt_skip]||false
		if lbSkip==true then
			verbose "Skipping case <"+pCase[:members]+">\n"
			return false
		end
				
		liTempfiles=`ls #{@tmpdir}/*.tmp|wc -l 2>/dev/null`
		system("rm #{@tmpdir}/*.tmp") if liTempfiles.to_i>0
		
		@action_counter=0		
		@action={ :id => 0, :weight => 1.0, :description => 'Empty description!'}
		@currentcase=pCase

		@result.reset
		@report.start_new_datagroup pCase
		@report.datagroup.tail[:unique_fault]=0

		verboseln "\nStarting case <"+get(:members)+">"
		return true
	end



	#Set command 
	def command(pCommand, pArgs={})
		@action[:command]=pCommand
		tempfile pArgs[:tempfile] if pArgs[:tempfile]
	end
	
	#Set description
	def description(pDescription)
		desc pDescription
	end
	
	def desc(pDescription)
		@action[:description]=pDescription
	end
	
	#Read param :pOption from the current case
	def get(pOption)
		return @currentcase[pOption] if @currentcase[pOption]
		return @global[pOption] if @global[pOption]
		return nil
	end
		
	def info(pText)
	end

	#Set temp filename
	def tempfile(pTempfile)
		@action[:tempfile]=pTempfile
		@action[:tempfile]='dvr_local.tmp' if (pTempfile==:reset or pTempfile==:default) 		
	end
	
	def path_to_tempfile(pTempfile)
		if pTempfile.nil? then
			pTempfile=@action[:tempfile] || 'dvr_local.tmp'
		end
		if pTempfile.split("/")[0]!=@tmpdir then
			lsLocalfile = @tmpdir+"/"+pTempfile
		else
			lsLocalfile = pTempfile
		end
		return lsLocalfile
	end
	
	#Set weight value for the action
	def weight(pValue)
		@action[:weight]=pValue.to_f
	end
	
	#Run command from the host identify as pHostname
	def run_on(pHostname)
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
		tempfile :reset
	end

	#Si se cumple la condición, entonces se registra el evento como un acierto.
	#En caso contrario se registra como un error.	
	def check(pCond)
		lWeight= @action[:weight].to_f || 1.0

		@action_counter+=1
		@action[:id]=@action_counter
		@action[:weight]=lWeight
		@action[:check]=pCond
		@report.datagroup.lines << @action.clone

		c="?"
		c="." if pCond
		verbose c
	end
	
	def log(pText, pType=:info)
		s="INFO: "
		s="WARN: " if pType==:warn
		s="ERROR: " if pType==:error
		@report.datagroup.lines << s+pText
	end

	def unique(psKey, psValue="")
		if @unique_values[psKey]==nil then
			@unique_values[psKey]=psValue
		else
			@report.datagroup.tail[:unique_fault]+=1
			log("Unique value (#{psKey}): #{psValue}",:error)
		end
	end

	#Muestra un mensaje en pantalla si está habilitado el modo verbose.
	def verboseln(psText)
		return if !@verbose
		puts psText
	end
	
	def verbose(psText)
		return if !@verbose
		print psText
	end

private

	#Verifica la existencia del directorio, en caso contrario lo crea.
	def ensure_dir(psDirname)
		if !Dir.exists?(psDirname) then
			#Dir.mkdir(psDirname)
			#TODO: Mod cross-platform. Not use system command.
			system("mkdir #{psDirname} -p")
			return false
		end
		return true
	end

	def execute(psCmd)
		return if @debug
		begin
			system(psCmd)
		rescue
			verbose "!"
			log ("Local exec: "+psCmd) #, :error)
		end
	end

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
		lsTempfile=@action[:tempfile] || 'dvr_local.tmp'
		
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
		lsTempfile=@action[:tempfile] || "dvr_remote.tmp"
		
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
			#verbose "\nERROR! #{lsText}\n"
			verbose "!"
			log(lsText) #, :error)
		end
		
		@result.content=read_filename(lsLocalfile)
	end
end
