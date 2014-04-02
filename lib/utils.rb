# encoding: utf-8

module Utils

	#Create the directory if it dosn't exist.
	def ensure_dir(psDirname)
		if !Dir.exists?(psDirname) then
			#Dir.mkdir(psDirname)
			#TODO: Mod cross-platform. Not use system command.
			execute("mkdir #{psDirname} -p")
			return false
		end
		return true
	end

	#Execute the system command if debug is false.
	def execute(psCmd)
		return if @debug
		begin
			system(psCmd)
		rescue
			verbose "!"
			log ("Local exec: "+psCmd) #, :error)
		end
	end

	#Show message on screen if verbose mode is true.
	def verboseln(psText)
		return if !@verbose
		puts psText
	end
	
	def verbose(psText)
		return if !@verbose
		print psText
	end
end
