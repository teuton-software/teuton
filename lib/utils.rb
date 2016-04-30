
module Utils

  # Create the directory if it dosn't exist.
  def ensure_dir(dirname)
    if !Dir.exists?(dirname) then
      puts dirname
      FileUtils.mkdir_p(dirname)
      return false
    end
    return true
  end

  def my_execute(psCmd)
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
