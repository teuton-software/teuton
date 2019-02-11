
class Case

  def start
    @skip=get(:tt_skip)||false
    if @skip==true then
      verbose "Skipping case <#{@config.get(:tt_members)}>\n"
      return false
    end

    names=@id.to_s+"-*.tmp"
    r=`ls #{@tmpdir}/#{names} 2>/dev/null | wc -l`
    execute("rm #{@tmpdir}/#{names}") if r[0].to_i>0 #Delete previous temp files

    start_time = Time.now
    if get(:tt_sequence) then
      verboseln "Starting case <"+@config.get(:tt_members)+">"
      @tasks.each do |t|
        verbose "* Processing <"+t[:name].to_s+"> "
        instance_eval &t[:block]
        verbose "\n"
      end
      verboseln "\n"
    else
      @tasks.each do |t|
        m="GROUP: #{t[:name]}"
        log("="*m.size)
        log(m)
        instance_eval &t[:block]
      end
    end

    finish_time=Time.now
    @report.head.merge! @config.local
    @report.tail[:case_id]=@id
    @report.tail[:start_time_]=start_time
    @report.tail[:finish_time]=finish_time
    @report.tail[:duration]=finish_time-start_time

    @sessions.each_value { |s| s.close if s.class==Net::SSH::Connection::Session }
  end
  alias_method :play, :start

end
