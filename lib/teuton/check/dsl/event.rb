module CheckDSL
  def event(**args, &block)
    # args = on: XXX, when: XXX
    @stats[:events] += 1
    if @action_manager.check_event(**args)
      Logger.puts "      event       on: #{args[:on]}, when: #{args[:when]}"
    else
      Logger.puts "ERROR event       on: #{args[:on]}, when: #{args[:when]}"
    end
  end
end
