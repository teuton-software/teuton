# frozen_string_literal: true

require_relative "../../case/dsl/macro"
require_relative "expect"
require_relative "run"

class Checker
  include DSL # Include DSL/macro functions only
  include CheckDSL

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

  def get(varname)
    @stats[:gets] += 1
    @gets[varname] = @gets[varname] ? (@gets[varname] + 1) : 1
    "get(#{varname})"
  end

  def gett(option)
    get(option)
  end

  def log(text = "", type = :info)
    @stats[:logs] += 1
    verboseln "      log    [#{type}]: " + text.to_s
  end

  def set(key, value)
    key = ":" + key.to_s if key.instance_of? Symbol
    value = ":" + value.to_s if value.instance_of? Symbol

    @stats[:sets] << "#{key}=#{value}"
    puts "      set(#{key},#{value})"
  end

  def unset(key)
    puts "      unset(#{key})"
  end

  def unique(key, _value)
    @stats[:uniques] += 1

    verboseln "    ! Unique      value for <#{key}>"
    verboseln ""
  end
end
