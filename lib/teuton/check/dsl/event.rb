module CheckDSL
  def event(**args, &block)
    # args = on: XXX, when: XXX
    @stats[:events] += 1
    Logger.puts "      event       on: #{args[:on]}, when: #{args[:when]}"
    @action_manager.check_event(**args)
  end
end
