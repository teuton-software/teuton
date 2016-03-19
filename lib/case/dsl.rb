# encoding: utf-8

require 'net/sftp'

module DSL

  def desc(pDescription=nil)
    target pDescription
  end

  def target(pDescription=nil)
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
  #goto :host1, :execute => "command"
  def on(pHostname=:localhost, pArgs={})
    verboseln("deprecated method on")
    goto(pHostname, pArgs)
  end
  
  def goto(pHostname=:localhost, pArgs={})
    command(pArgs[:execute]) if pArgs[:execute]
    command(pArgs[:exec]) if pArgs[:exec]
    tempfile(pArgs[:tempfile]) if pArgs[:tempfile]
	
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

  #expect <condition>, :weight => <value>
  def expect(pCond, pArgs={})
    @action[:weight]=pArgs[:weight].to_f if pArgs[:weight]
    lWeight= @action[:weight]

    @action_counter+=1
    @action[:id]=@action_counter
    @action[:weight]=lWeight
    @action[:check]=pCond
    @action[:result]=@result.value
    
    @action[:expected]=@result.expected
    @action[:expected]=pArgs[:expected] if pArgs[:expected]
    
    @report.lines << @action.clone

    c="?"
    c="." if pCond
    verbose c
  end
	
  def log(pText="", pType=:info)
    s=""
    s=Rainbow("WARN:").color(:yellow)+" " if pType==:warn
    s=Rainbow("ERROR:").bg(:red)+" " if pType==:error
    @report.lines << s+pText
  end
			
  def unique( key, value )
    return if value.nil?
    k=(key.to_s+"="+value.to_s).to_sym
    @uniques << k
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
  
  def tempdir
    @tmpdir
  end

  def remote_tempfile		
    return @action[:remote_tempfile]
  end
  
  def remote_tempdir
    @remote_tmpdir
  end

  def send(pArgs={})
    #format=pArgs[:format] || :txt
    format=@report.format
    
    if pArgs[:copy_to] then

      host=pArgs[:copy_to].to_s
      ip=get((host+'_ip').to_sym)
      username=get((host+'_username').to_sym)
      password=get((host+'_password').to_sym)
      
      filename="case-#{id_to_s}.#{format}"
      localfilepath=File.join(tempdir,"../out/",filename)
      remotefilepath=File.join(remote_tempdir,filename)
       
      # upload a file or directory to the remote host
      begin
        Net::SFTP.start(ip, username, :password => password) do |sftp|
          sftp.upload!(localfilepath, remotefilepath)
        end
        verboseln("[ OK  ] #{get(:tt_members)}: scp <#{remotefilepath}>")
      rescue
        verboseln("[ERROR] #{get(:tt_members)}: scp <#{localfilepath}> => <#{remotefilepath}>")
      end
    end
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
    @result.content = my_execute( @action[:command] )	
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
