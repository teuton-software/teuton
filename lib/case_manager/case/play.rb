# Case class:
# * play method
class Case
  def play
    @skip = get(:tt_skip) || false
    if @skip == true
      verbose "Skipping case <#{@config.get(:tt_members)}>\n"
      return false
    end

    # FIXTHIS: Delete previous temp files
    # names = @id.to_s+"-*.tmp"
    # r=`ls #{@tmpdir}/#{names} 2>/dev/null | wc -l`
    # execute("rm #{@tmpdir}/#{names}") if r[0].to_i>0

    start_time = Time.now
    if get(:tt_sequence) # Play in sequence
      verboseln "Starting case <#{@config.get(:tt_members)}>"
      @groups.each do |t|
        verbose "* Processing <#{t[:name]}> "
        instance_eval(&t[:block])
        verbose "\n"
      end
      verboseln "\n"
    else # Play in parallel
      @groups.each do |t|
        m = "GROUP: #{t[:name]}" # REMOVE this when update report
        log('=' * m.size)
        log(m)
        @action[:groupname] = t[:name]
        instance_eval(&t[:block])
      end
    end

    finish_time = Time.now
    @report.head.merge! @config.local
    @report.tail[:case_id] = @id
    @report.tail[:start_time_] = start_time
    @report.tail[:finish_time] = finish_time
    @report.tail[:duration] = finish_time - start_time

    @sessions.each_value do |s|
      s.close if s.class == Net::SSH::Connection::Session
    end
  end
  alias start play
end
