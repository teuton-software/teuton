# frozen_string_literal: true

##
# Include Teuton DSL keywords into Laboratory class
class Laboratory
  ##
  # Execute Teuton DSL readme keyword
  def readme(_text)
    # Usefull for "teuton readme" command action.
  end

  ##
  # Execute Teuton DSL target keyword
  def target(desc, args = {})
    @stats[:targets] += 1
    @targetid += 1
    weight = args[:weight] || 1.0
    verboseln format('(%03<targetid>d) target      %<desc>s', targetid: @targetid, desc: desc)
    verboseln "      weight      #{weight}"
  end
  alias goal target

  ##
  # Execute Teuton DSL run keyword
  def run(command, args = {})
    args[:exec] = command
    host = :localhost
    host = args[:on] if args[:on]
    goto(host, args)
  end

  ##
  # Execute Teuton DSL goto keyword
  def goto(host = :localhost, args = {})
    result.reset
    args[:on] = host unless args[:on]

    if @hosts[host]
      @hosts[host] += 1
    else
      @hosts[host] = 1
    end
    verboseln "      run         '#{args[:exec]}' on #{args[:on]}"
  end

  ##
  # Execute Teuton DSL expect keyword
  def expect(cond)
    verboseln "      alter       #{result.alterations}" unless result.alterations.empty?
    verboseln "      expect      #{cond} (#{cond.class})"
    verboseln ''
  end

  ##
  # Execute Teuton DSL expect_one keyword
  def expect_one(cond)
    verboseln "      alter       #{result.alterations}" unless result.alterations.empty?
    verboseln "      expect_one  #{cond} (#{cond.class})"
    verboseln ''
  end

  ##
  # Execute Teuton DSL expect_none keyword
  def expect_none(cond)
    verboseln "      alter       #{result.alterations}" unless result.alterations.empty?
    verboseln "      expect_none #{cond} (#{cond.class})"
    verboseln ''
  end

  ##
  # Execute Teuton DSL get keyword
  def get(varname)
    @stats[:gets] += 1

    if @gets[varname]
      @gets[varname] += 1
    else
      @gets[varname] = 1
    end

    "get(#{varname})"
  end

  # If a method call is missing, then try to call get(var)
  # rubocop:disable Style/MissingRespondToMissing
  def method_missing(method)
    a = method.to_s
    instance_eval("get(:#{a[0, a.size - 1]})", __FILE__, __LINE__) if a[a.size - 1] == '?'
  end
  # rubocop:enable Style/MissingRespondToMissing

  ##
  # Execute Teuton DSL gett keyword
  # Same as get keyword, but show pretty output when used by readme command.
  def gett(option)
    value = get(option)
    value
  end

  ##
  # Execute Teuton DSL unique keyword
  def unique(key, _value)
    @stats[:uniques] += 1

    verboseln "    ! Unique      value for <#{key}>"
    verboseln ''
  end

  ##
  # Execute Teuton DSL log keyword
  def log(text = '', type = :info)
    @stats[:logs] += 1
    verboseln "      log    [#{type}]: " + text.to_s
  end

  ##
  # Execute Teuton DSL set keyword
  def set(key, value)
    @stats[:sets] += 1

    key = ':' + key.to_s if key.class == Symbol
    value = ':' + value.to_s if value.class == Symbol

    @sets[key] = value
    "set(#{key},#{value})"
  end
end
