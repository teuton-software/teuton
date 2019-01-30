# encoding: utf-8

module DSL

  def target(text=nil)
    return @action[:description] if text.nil?
    @action[:description] = text
  end
  alias_method :goal, :target

  def request(text)
    # do nothing
  end

  def command(pCommand, pArgs={})
    @action[:command] = pCommand
    tempfile(pArgs[:tempfile]) if pArgs[:tempfile]
  end

  #Read param pOption from [running, config or global] Hash data
  def get(pOption)
    @config.get(pOption)
  end

  def set( key, value)
    @config.set(key,value)
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
    @action[:encoding] = pArgs[:encoding] || 'UTF-8'

    start_time = Time.now
    if pHostname==:localhost || pHostname=='localhost' || pHostname.to_s.include?('127.0.0.') then
      run_local_cmd()
    else
      ip = get((pHostname.to_s+'_ip').to_sym)
      if ip.nil? then
        log("#{pHostname} IP is nil!",:error)
      elsif ip.include?('127.0.0.') then
        run_local_cmd
      else
        run_remote_cmd pHostname
      end
    end
    @action[:duration] = (Time.now-start_time).round(3)
  end

  alias_method :on, :goto

  def run(command, args={} )
    args[:exec] = command.to_s
    goto( :localhost, args)
  end

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

  alias_method :msg, :log

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
end
