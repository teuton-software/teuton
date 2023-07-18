# frozen_string_literal: true

# Readme
#   readme, target, goto, run
#   expect,
#   gett, set, unique, log
class Readme
  def readme(text)
    if @action[:target].nil?
      # It's a group readme
      @current[:readme] << text
    else
      # It's a target readme
      @action[:readme] << text
    end
  end

  def target(desc, args = {})
    previous_host = @action[:host]
    @action = {target: desc, host: previous_host, readme: []}
    weight = 1.0
    weight = args[:weight].to_f if args[:weight]
    @action[:weight] = weight
  end
  alias_method :goal, :target

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

  def expect(_cond, _args = {})
    @current[:actions] << @action
    result.reset
  end
  alias_method :expect_any, :expect
  alias_method :expect_first, :expect
  alias_method :expect_last, :expect
  alias_method :expect_none, :expect
  alias_method :expect_one, :expect

  def get(value)
    unless @config[:global][value].nil?
      @global_params[value] = @config[:global][value]
      return @config[:global][value]
    end

    return value.to_s.upcase if @setted_params.include? value

    @cases_params << value
    value.to_s.upcase
  end

  # If a method call is missing, then delegate to concept parent.
  # def method_missing(method, args = {})
  def method_missing(method, *args, &block)
    m = method.to_s
    if m[0] == "_"
      instance_eval("get(:#{m[1, m.size - 1]})", __FILE__, __LINE__)
    # elsif not Application.instance.macros[m].nil?
    elsif !Project.value[:macros][m].nil?
      puts "macro exec: #{m}"
      code = ""
      args[0].keys.each { |key| code += "set(:#{key}, '#{args[0][key]}')\n" }
      puts code
      # instance_eval(code)
      # Application.instance.macros[m].call
    end
  end

  def respond_to_missing?(method_name, include_private = false)
    true
  end

  def gett(value)
    a = get(value)
    if @cases_params.include? value
      "[#{value}](#required-params)"
    elsif @setted_params[value]
      "[#{value}](#created-params)"
    elsif @global_params.include? value
      "[#{a}](#global-params)"
    end
    a
  end

  def set(key, value)
    @setted_params[key] = value
  end

  def unique(_key, _value)
    # don't do nothing
  end

  def log(text = "", type = :info)
    @data[:logs] << "[#{type}]: " + text.to_s
  end
end
