# encoding: utf-8

require 'net/sftp'
require 'net/telnet'

module DSL

  def target(pDescription=nil)
    return @action[:description] if pDescription.nil?
    @action[:description]=pDescription
  end
  alias_method :desc, :target
  	
  def command(pCommand, pArgs={})
    @action[:command]=pCommand
    tempfile(pArgs[:tempfile]) if pArgs[:tempfile]
  end

  #Read param pOption from [running, config or global] Hash data
  def get(pOption)
    return @running_config[pOption] if @running_config[pOption]
    return @case_config[pOption]    if @case_config[pOption]
    return @global_config[pOption]  if @global_config[pOption]
    return nil
  end

  def set( key, value)
    @running_config[key]=value
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
  def goto(pHostname=:localhost, pArgs={})
    @result.reset
    command(pArgs[:execute]) if pArgs[:execute]
    command(pArgs[:exec]) if pArgs[:exec]
    tempfile(pArgs[:tempfile]) if pArgs[:tempfile]
	
    if pHostname==:localhost || pHostname=='localhost' || pHostname.to_s.include?('127.0.0.') then
      run_local_cmd
    else
      key=( (pHostname.to_s.split('_')[0])+'_ip' ).to_sym
      ip=get( key )
      if ip.nil? then
        log("IP nil!",:error)
      elsif ip.include?('127.0.0.') then
        run_local_cmd
      else
        run_remote_cmd pHostname
      end
    end
  end

  alias_method :on, :goto

  #expect <condition>, :weight => <value>
  def expect(pCond, pArgs={})
    weight(pArgs[:weight])
    lWeight= @action[:weight]

    @action_counter+=1
    @action[:id]=@action_counter
    @action[:weight]=lWeight
    @action[:check]=pCond
    @action[:result]=@result.value
    
    @action[:alterations]=@result.alterations
    @action[:expected]=@result.expected
    @action[:expected]=pArgs[:expected] if pArgs[:expected]
    
    @report.lines << @action.clone
    weight(1.0)

    app=Application.instance
    c=app.letter[:bad]
    c=app.letter[:good] if pCond
    verbose c
  end
	
  def log(pText="", pType=:info)
    s=""
    s=Rainbow("WARN!:").color(:yellow)+" " if pType==:warn
    s=Rainbow("ERROR:").bg(:red)+" " if pType==:error
    @report.lines << s+pText.to_s
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
    return if get(:tt_skip)
    
    #format=pArgs[:format] || :txt
    format=@report.format
    
    if pArgs[:copy_to] then

      host=pArgs[:copy_to].to_s
      ip=get((host+'_ip').to_sym)
      username=get((host+'_username').to_sym)
      password=get((host+'_password').to_sym)
      
      filename="case-#{id_to_s}.#{format}"
      localfilepath=File.join(tempdir,"../out/",filename)
      if pArgs[:remote_dir]
        remotefilepath=File.join(pArgs[:remote_dir],filename) 
      else
        remotefilepath=File.join(remote_tempdir,filename)
      end
           
      # upload a file or directory to the remote host
      begin
        Net::SFTP.start(ip, username, :password => password) do |sftp|
          sftp.upload!(localfilepath, remotefilepath)
        end
        verboseln("=> [ OK  ] #{get(:tt_members)}: <#{remotefilepath}>")
      rescue
        verboseln("=> [ERROR] #{get(:tt_members)}: scp <#{localfilepath}> => <#{remotefilepath}>")
      end
    end
  end
  
end
