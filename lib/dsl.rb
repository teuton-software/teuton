#!/usr/bin/ruby
# encoding: utf-8

module DSL

	def desc(pDescription=nil)
		description pDescription
	end
	
	def description(pDescription=nil)
		return @action[:description] if pDescription.nil?
		@action[:description]=pDescription
	end
	
	def command(pCommand, pArgs={})
		@action[:command]=pCommand
		desc(pArgs[:desc]) if pArgs[:desc]
		description(pArgs[:description]) if pArgs[:description]
		tempfile(pArgs[:tempfile]) if pArgs[:tempfile]
	end

	#Read param pOption from config or global Hash data
	def get(pOption)
		return @config[pOption] if @config[pOption]
		return @global[pOption] if @global[pOption]
		return nil
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
		if pHostname==:localhost || pHostname=='localhost' || pHostname.to_s.include?('127.0.0.') then
			run_local_cmd
		else
			key=( (pHostname.to_s.split('_')[0])+'_ip' ).to_sym
			ip=get( key )
			if ip.include?('127.0.0.') then
				run_local_cmd
			else
				run_remote_cmd pHostname
			end
		end
	end

	def check(pCond, pArgs={})
		@action[:weight]=pArgs[:weight].to_f if pArgs[:weight]
		lWeight= @action[:weight]

		@action_counter+=1
		@action[:id]=@action_counter
		@action[:weight]=lWeight
		@action[:check]=pCond
		@report.lines << @action.clone

		c="?"
		c="." if pCond
		verbose c
	end
	
	def log(pText="", pType=:info)
		s="INFO: "
		s="WARN: " if pType==:warn
		s="ERROR: " if pType==:error
		@report.lines << s+pText
	end
			
	def unique( key, value )
		@uniques[key] = value 
		#if @unique_values[psKey]==nil then
		#	@unique_values[psKey]=psValue
		#else
		#	@report.tail[:unique_fault]+=1
		#	log("Unique value (#{psKey}): #{psValue}",:error)
		#end
	end
	
	def tempfile(pTempfile=nil)
		ext='.tmp'
		pre=@id.to_s+"-"
		if pTempfile.nil? then
			return @action[:tempfile]
		elsif pTempfile==:default 
			@action[:tempfile]=File.join(@tmpdir, pre+'tt_local'+ext)
			@action[:remote_tempfile]=File.join(@remote_tmpdir, pre+'tt_remote'+ext)
		else
			@action[:tempfile]=File.join(@tmpdir, pre+pTempfile+ext)
			@action[:remote_tempfile]=File.join(@remote_tmpdir, pre+pTempfile+ext)
		end
		
		return @action[:tempfile]
	end

	def remote_tempfile		
		return @action[:remote_tempfile]
	end

private

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
	
	def run_local_cmd
		@result.content = execute( @action[:command] )	
	end
	
	def run_remote_cmd(pHostname) 		
		hostname=pHostname.to_s
		ip=get((hostname+'_ip').to_sym)
		username=get((hostname+'_username').to_sym)
		password=get((hostname+'_password').to_sym)
		output=[]
		
		begin
			if @sessions[hostname].nil?
				@sessions[hostname] = Net::SSH.start(ip, username, :password => password)
			end
			
			if @sessions[hostname].class==Net::SSH::Connection::Session
				text=@sessions[hostname].exec!( @action[:command] )
				output = text.split("\n")
			end
		rescue Errno::EHOSTUNREACH
			@sessions[hostname]=:nosession
			verbose "!"
			log( "Host #{ip} unreachable!", :error)
		rescue Net::SSH::AuthenticationFailed
			@sessions[hostname]=:nosession
			verbose "!"
			log( "SSH::AuthenticationFailed!", :error)
		rescue Exception => e
			@sessions[hostname]=:nosession
			verbose "!"
			log( "[#{e.class.to_s}] SSH on <#{username}@#{ip}> exec: "+@action[:command], :error)
		end
		
		@result.content=output
	end
end
