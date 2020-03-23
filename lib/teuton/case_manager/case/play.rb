# frozen_string_literal: true

# Case class:
# * play
# * play_in_parallel
# * play_in_sequence
# * fill_report
# * close_opened_sessions
class Case
  ##
  # Execute "play" order on this case
  def play
    if skip?
      verbose "Skipping case <#{@config.get(:tt_members)}>\n"
      return false
    end
    # TODO: Delete old reports???
    start_time = Time.now
    play_in_sequence if get(:tt_sequence) == true # Play in sequence
    play_in_parallel if get(:tt_sequence) != true # Play in parallel
    fill_report(start_time, Time.now)
    close_opened_sessions
  end
  alias start play

  ##
  # Close opened sessions for this case
  def close_opened_sessions
    @sessions.each_value do |s|
      s.close if s.class == Net::SSH::Connection::Session
    end
  end

  private

  ##
  # Execute every play#group in parallel
  # TO-DO: Under construction!
  def play_in_parallel
    @groups.each do |t|
      @action[:groupname] = t[:name]
      instance_eval(&t[:block])
    end
  end

  ##
  # Execute every play#group in sequence
  def play_in_sequence
    verboseln "Starting case <#{@config.get(:tt_members)}>"
    @groups.each do |t|
      verbose "* Processing <#{t[:name]}> "
      @action[:groupname] = t[:name]
      instance_eval(&t[:block])
      verbose "\n"
    end
    verboseln "\n"
  end

  ##
  # Fill case report with time information
  def fill_report(start_time, finish_time)
    @report.head.merge! @config.global
    @report.head.merge! @config.local
    @report.head.merge! @config.running
    @report.tail[:case_id] = @id
    @report.tail[:start_time] = start_time
    @report.tail[:finish_time] = finish_time
    @report.tail[:duration] = finish_time - start_time
  end
end
