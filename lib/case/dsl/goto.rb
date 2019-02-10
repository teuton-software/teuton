# encoding: utf-8

module DSL

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

  def command(pCommand, pArgs={})
    @action[:command] = pCommand
    tempfile(pArgs[:tempfile]) if pArgs[:tempfile]
  end

end
