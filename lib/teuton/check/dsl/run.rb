module CheckDSL
  def run(command, args = {})
    args[:exec] = command
    host = :localhost
    host = args[:on] if args[:on]
    goto(host, args)
  end

  def run_file(command, args = {})
    host = :localhost
    host = args[:on] if args[:on]
    filename = command.split[1]
    upload filename, to: host
    run command, args
  end

  def goto(host = :localhost, args = {})
    result.reset
    @stats[:hosts][host] = @stats[:hosts][host] ? (@stats[:hosts][host] + 1) : 1
    verboseln "      run         '#{args[:exec]}' on #{host}"
  end

  def upload(filename, args = {})
    host = args[:to]
    args.delete(:to)
    custom = if args == {}
      ""
    else
      values = args.map { "#{_1}=#{_2}" }
      "and #{values.join(",")}"
    end
    @stats[:uploads] << filename
    verboseln "      upload      '#{filename}' to #{host} #{custom}"
  end
end
