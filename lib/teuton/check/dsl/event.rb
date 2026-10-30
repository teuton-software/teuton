module CheckDSL
  def event(**args)
    if @action_manager.check_event(args)
      @stats[:events] += 1
      Logger.puts "   \u{1f5f2}  event       on: #{args[:on]}, when: #{args[:when]}"
    else
      Logger.puts "    \u{2718} event       on: #{args[:on]}, when: #{args[:when]} (UNKOWN!)"
    end
  end
end
