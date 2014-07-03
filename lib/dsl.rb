#!/usr/bin/ruby
# encoding: utf-8

module DSL
	def command(pCommand, pArgs={})
		@action[:command]=pCommand
		tempfile(pArgs[:tempfile]) if pArgs[:tempfile]
	end

	def description(pDescription=nil)
		desc pDescription
	end
	
	def desc(pDescription=nil)
		return @action[:description] if pDescription.nil?
		@action[:description]=pDescription
	end
	
	#Set weight value for the action
	def weight(pValue=nil)
		if pValue.nil? then
			return @action[:weight]
		elsif pValue==:default then
			@action[:weight]=1.0
		else
		@action[:weight]=pValue.to_f
		end
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
	
	#Set temp filename
	def tempfile(pTempfile=:default)
		if (pTempfile.nil? or pTempfile==:default) 
			@action[:tempfile]=File.join(@tmpdir,'tt_local.tmp')
			@action[:remote_tempfile]=File.join(@remote_tmpdir,'tt_remote.tmp')
		else
			@action[:tempfile]=File.join(@tmpdir, pTempfile)
			@action[:remote_tempfile]=File.join(@remote_tmpdir, pTempfile)
		end
		
		return @action[:tempfile]
	end

	def remote_tempfile		
		return @action[:remote_tempfile]
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
		lsCmd=@action[:command]+' > '+@action[:tempfile]
		execute(lsCmd) 
		@result.content= read_filename(@action[:tempfile])	
	end
	
	#Ejecuta un comando en maquina remota a través de SSH.
	def run_remote_cmd(pHostname) 
		
		hostname=pHostname.to_s
		lsIP=get((hostname+'_ip').to_sym)
		lsUsername=get((hostname+'_username').to_sym)
		lsPassword=get((hostname+'_password').to_sym)

		lsRemotefile = remote_tempfile
		lsLocalfile = tempfile
		lsCmd=@action[:command]+" > "+lsRemotefile
		
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
