# frozen_string_literal: true

# Readme
# * target
# * goto
# * run
# * expect
# * unique
# * log
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
    @action = { target: desc, host: previous_host, readme: [] }
    weight = 1.0
    weight = args[:weight].to_f if args[:weight]
    @action[:weight] = weight
  end
  alias goal target

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
    @action[:exec] = args[:exec] || 'noexec'
  end

  def run(command, args = {})
    args[:exec] = command
    goto(:localhost, args)
  end

  def expect(_cond, _args = {})
    @current[:actions] << @action
    result.reset
  end
  alias expect_any expect
  alias expect_none expect
  alias expect_one expect

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
  def method_missing(method)
    a = method.to_s
    instance_eval("get(:#{a[0, a.size - 1]})") if a[a.size - 1] == '?'
  end

  def gett(value)
    a = get(value)
    return "[#{value}](\#required-params)" if @cases_params.include? value
    return "[#{value}](\#created-params)" if @setted_params[value]

    "[#{a}](\#global-params)" if @global_params.include? value
  end

  def set(key, value)
    @setted_params[key] = value
  end

  def unique(_key, _value)
    # don't do nothing
  end

  def log(text = '', type = :info)
    @data[:logs] << "[#{type}]: " + text.to_s
  end
end
