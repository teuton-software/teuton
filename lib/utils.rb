# encoding: utf-8

module Utils

	#Create the directory if it dosn't exist.
	def ensure_dir(psDirname)
		if !Dir.exists?(psDirname) then
			#Dir.mkdir(psDirname)
			#TODO: Mod cross-platform. Not use system command.
			execute("mkdir #{psDirname} -p")
			#File.mkdir(psDirname)
			return false
		end
		return true
	end

	def execute(psCmd)
		output=[]
		return output if @debug
		begin
			text=`#{psCmd}`
			output=text.split("\n")
		rescue
			verbose "!"
			log ("Local exec: "+psCmd) #, :error)
		end
		return output
	end

	def verboseln(psText)
		verbose(psText+"\n")
	end
	
	def verbose(psText)
		return if !@verbose
		print psText
	end
end
