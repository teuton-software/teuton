# frozen_string_literal: true

class Case
  # Case class: play
  # TODO: Encapsulate code into PlayManager class
  # * play_in_parallel, play_in_sequence, fill_report, close_opened_sessions
  # READ: sessions, config, groups, action, report
  # TODO: groups from Project or from Case???
  def play
    if skip?
      verbose Rainbow("S").green
      return false
    end
    start_time = Time.now
    play_groups_in_sequence
    fill_report(start_time, Time.now)
    close_opened_sessions
  end
  alias_method :start, :play

  def close_opened_sessions
    @sessions.each_value do |s|
      s.close if s.instance_of? Net::SSH::Connection::Session
    end
  end

  private

  def play_groups_in_sequence
    verboseln "\n=> Starting case [#{@config.get(:tt_members)}]" if get(:tt_sequence) == true
    @groups.each do |t|
      @action[:groupname] = t[:name]
      # TODO: @parent(case).instance_eval(&t[:block])
      instance_eval(&t[:block])
    end
  end

  def play_groups_in_parallel
    verboseln "Starting case [#{@config.get(:tt_members)}]"
    @groups.each do |t|
      verbose "* Processing [#{t[:name]}] "
      @action[:groupname] = t[:name]
      instance_eval(&t[:block])
      verbose "\n"
    end
    verboseln "\n"
  end

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
