module ReadmeDSL
  def goto(host = :localhost, args = {})
    unless host == :localhost
      b = {}
      a = :"#{host}_ip"
      if @config[:global][a].nil? && !@setted_params.include?(a)
        @cases_params << a
      end
      b[:ip] = @config[:global][a] if @config[:global][a]
      b[:ip] = @setted_params[a] if @setted_params[a]

      a = :"#{host}_username"
      if @config[:global][a].nil? && !@setted_params.include?(a)
        @cases_params << a
      end
      b[:username] = @config[:global][a] if @config[:global][a]
      b[:username] = @setted_params[a] if @setted_params[a]

      a = :"#{host}_password"
      if @config[:global][a].nil? && !@setted_params.include?(a)
        @cases_params << a
      end
      b[:password] = @config[:global][a] if @config[:global][a]
      b[:password] = @setted_params[a] if @setted_params[a]

      @required_hosts[host.to_s] = b
    end
    @action[:host] = host
    @action[:exec] = args[:exec] || "noexec"
  end

  def run(command, args = {})
    args[:exec] = command
    host = :localhost
    host = args[:on] if args[:on]
    goto(host, args)
  end

  def run_script(command, args = {})
    host = :localhost
    host = args[:on] if args[:on]
    filename = command.split[1]
    upload filename, on: host
    run command, args = {}
    goto(host, args)
  end

  def upload(filename, args = {})
    # Nothing to do
  end
end
