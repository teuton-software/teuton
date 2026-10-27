module CheckDSL
  def event(**args, &block)
    # args = on: XXX, when: XXX
    type = @action_manager.get_event_type(**args)
    if type.nil?
      Logger.puts "      event       on: #{args[:on]}, when: #{args[:when]} (UNKOWN!)"
      return
    end
    @stats[:events][type] += 1
    Logger.puts "      event       on: #{args[:on]}, when: #{args[:when]} (run #{type})"
  end
end
