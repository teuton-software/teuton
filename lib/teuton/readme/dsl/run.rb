module ReadmeDSL
  def goto(host = :localhost, args = {})
    unless host == :localhost
      b = {}
      a = "#{host}_ip".to_sym
      if @config[:global][a].nil? && !@setted_params.include?(a)
        @cases_params << a
      end
      b[:ip] = @config[:global][a] if @config[:global][a]
      b[:ip] = @setted_params[a] if @setted_params[a]

      a = "#{host}_username".to_sym
      if @config[:global][a].nil? && !@setted_params.include?(a)
        @cases_params << a
      end
      b[:username] = @config[:global][a] if @config[:global][a]
      b[:username] = @setted_params[a] if @setted_params[a]

      a = "#{host}_password".to_sym
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

  def run_file(command, args = {})
    host = :localhost
    host = args[:on] if args[:on]
    filename = command.split[1]
    upload filename, on: host
    run command, args = {}
    goto(host, args)
  end

  # def method_missing(method, *args, &block)
  #   m = method.to_s
  #   if m[0] == "_"
  #     instance_eval("get(:#{m[1, m.size - 1]})", __FILE__, __LINE__)
  #  # elsif not Application.instance.macros[m].nil?
  #  elsif !Project.value[:macros][m].nil?
  #    puts "macro exec: #{m}"
  #    code = ""
  #    args[0].keys.each { |key| code += "set(:#{key}, '#{args[0][key]}')\n" }
  #    puts code
  #    # instance_eval(code)
  #    # Application.instance.macros[m].call
  #  end
  # end

  # def respond_to_missing?(method_name, include_private = false)
  #  true
  # end
end
