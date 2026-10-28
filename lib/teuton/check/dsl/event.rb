module CheckDSL
  def event(**args)
    type = @action_manager.get_event_type(**args)
    if type.nil?
      Logger.puts "    \u{2718} event       on: #{args[:on]}, when: #{args[:when]} (UNKOWN!)"
      return
    end
    @stats[:events][type] += 1
    Logger.puts "   \u{1f5f2}  event       on: #{args[:on]}, when: #{args[:when]} (run #{type})"
  end
end
