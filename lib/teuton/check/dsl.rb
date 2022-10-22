# frozen_string_literal: true

##
# Include Teuton DSL keywords into Laboratory class
class Laboratory
  def readme(_text)
    # Usefull for "teuton readme" command action.
  end

  def target(desc, args = {})
    @stats[:targets] += 1
    @targetid += 1
    weight = args[:weight] || 1.0
    verboseln format("(%03<targetid>d) target      %<desc>s", targetid: @targetid, desc: desc)
    verboseln "      weight      #{weight}"
  end
  alias goal target

  def expect(cond)
    verboseln "      alter       #{result.alterations}" unless result.alterations.empty?
    verboseln "      expect      #{cond} (#{cond.class})"
    verboseln ""
  end

  def expect_first(cond)
    verboseln "      alter        #{result.alterations}" unless result.alterations.empty?
    verboseln "      expect_first #{cond} (#{cond.class})"
    verboseln ""
  end

  def expect_last(cond)
    verboseln "      alter        #{result.alterations}" unless result.alterations.empty?
    verboseln "      expect_last #{cond} (#{cond.class})"
    verboseln ""
  end

  def expect_none(cond)
    verboseln "      alter       #{result.alterations}" unless result.alterations.empty?
    verboseln "      expect_none #{cond} (#{cond.class})"
    verboseln ""
  end

  def expect_one(cond)
    verboseln "      alter       #{result.alterations}" unless result.alterations.empty?
    verboseln "      expect_one  #{cond} (#{cond.class})"
    verboseln ""
  end

  def get(varname)
    @stats[:gets] += 1

    if @gets[varname]
      @gets[varname] += 1
    else
      @gets[varname] = 1
    end

    "get(#{varname})"
  end

  def run(command, args = {})
    args[:exec] = command
    host = :localhost
    host = args[:on] if args[:on]
    goto(host, args)
  end

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

  # Check macros and _get_vars
  def method_missing(method)
    a = method.to_s
    instance_eval("get(:#{a[0, a.size - 1]})", __FILE__, __LINE__) if a[a.size - 1] == "?"
  end

  def gett(option)
    get(option)
  end

  def unique(key, _value)
    @stats[:uniques] += 1

    verboseln "    ! Unique      value for <#{key}>"
    verboseln ""
  end

  def log(text = "", type = :info)
    @stats[:logs] += 1
    verboseln "      log    [#{type}]: " + text.to_s
  end

  def set(key, value)
    @stats[:sets] += 1

    key = ":" + key.to_s if key.instance_of? Symbol
    value = ":" + value.to_s if value.instance_of? Symbol

    @sets[key] = value
    "set(#{key},#{value})"
  end
end
