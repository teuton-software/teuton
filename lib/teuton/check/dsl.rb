# frozen_string_literal: true

class Laboratory
  # Include Teuton DSL keywords into Laboratory class
  def readme(_text)
    # Usefull for "teuton readme" command action.
  end

  def target(desc, args = {})
    if @target_begin
      puts Rainbow("WARN  Previous 'target' requires 'expect'").bright.yellow
    end
    @target_begin = true
    @stats[:targets] += 1
    @targetid += 1
    weight = args[:weight] || 1.0
    verboseln format("(%03<targetid>d) target      %<desc>s", targetid: @targetid, desc: desc)
    verboseln "      weight      #{weight}"
  end
  alias_method :goal, :target

  def expect(cond)
    unless @target_begin
      puts Rainbow("WARN  'expect' with no previous 'target'").bright.yellow
    end
    verboseln "      alter       #{result.alterations}" unless result.alterations.empty?
    verboseln "      expect      #{cond} (#{cond.class})"
    verboseln ""
    @target_begin = false
  end

  def expect_exit(cond)
    unless @target_begin
      puts Rainbow("WARN  'expect' with no previous 'target'").bright.yellow
    end
    verboseln "      expect_exit #{cond} (#{cond.class})"
    verboseln ""
    @target_begin = false
  end

  def expect_fail
    unless @target_begin
      puts Rainbow("WARN  'expect' with no previous 'target'").bright.yellow
    end
    verboseln "      expect_fail"
    verboseln ""
    @target_begin = false
  end

  def expect_first(cond)
    unless @target_begin
      puts Rainbow("WARN  'expect' with no previous 'target'").bright.yellow
    end
    verboseln "      alter        #{result.alterations}" unless result.alterations.empty?
    verboseln "      expect_first #{cond} (#{cond.class})"
    verboseln ""
    @target_begin = false
  end

  def expect_last(cond)
    unless @target_begin
      puts Rainbow("WARN  'expect' with no previous 'target'").bright.yellow
    end
    verboseln "      alter        #{result.alterations}" unless result.alterations.empty?
    verboseln "      expect_last #{cond} (#{cond.class})"
    verboseln ""
    @target_begin = false
  end

  def expect_none(cond)
    unless @target_begin
      puts Rainbow("WARN  'expect' with no previous 'target'").bright.yellow
    end
    verboseln "      alter       #{result.alterations}" unless result.alterations.empty?
    verboseln "      expect_none #{cond} (#{cond.class})"
    verboseln ""
    @target_begin = false
  end

  def expect_one(cond)
    unless @target_begin
      puts Rainbow("WARN  'expect' with no previous 'target'").bright.yellow
    end
    verboseln "      alter       #{result.alterations}" unless result.alterations.empty?
    verboseln "      expect_one  #{cond} (#{cond.class})"
    verboseln ""
    @target_begin = false
  end

  def get(varname)
    @stats[:gets] += 1
    @gets[varname] = @gets[varname] ? (@gets[varname] + 1) : 1
    "get(#{varname})"
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
    upload filename, to: host
    run command, args
  end

  def goto(host = :localhost, args = {})
    result.reset
    args[:on] = host unless args[:on]
    @hosts[host] = @hosts[host] ? (@hosts[host] + 1) : 1
    verboseln "      run         '#{args[:exec]}' on #{args[:on]}"
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
    verboseln "      upload      '#{filename}' to #{host} #{custom}"
  end

  # Check macros and _get_vars
  def method_missing(method, *args, &block)
    a = method.to_s
    if a.start_with?("_") && args.nil? && block.nil?
      instance_eval("get(:#{a[0, a.size - 1]})", __FILE__, __LINE__) if a[a.size - 1] == "?"
    end
    puts Rainbow("WARN  Unkown call '#{a}'").bright.yellow
  end

  def respond_to_missing?(method_name, include_private = false)
    true
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
