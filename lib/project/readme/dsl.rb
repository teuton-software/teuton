# frozen_string_literal: true

# Readme
# * target
# * goto
# * run
# * expect
# * unique
# * log
class Readme
  def reset_action
    @action = {}
  end

  def target(desc, args = {})
    previous_host = @action[:host]
    @action = { target: desc, host: previous_host }
    weight = 1.0
    weight = args[:weight].to_f if args[:weight]
    @action[:weight] = weight
  end
  alias goal target

  def goto(host = :localhost, args = {})
    unless host == :localhost
      @required_hosts << host.to_s
    end
    @action[:host] = host
    @action[:exec] = args[:exec] || 'noexec'
  end

  def run(command, args = {})
    args[:exec] = command
    goto(:localhost, args)
  end

  def expect(_cond, args = {})
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

  def gett(value)
    return "VALUE (#{value})" if @cases_params.include? value
    return "VALUE (#{value})" if @setted_params.include? value

    get(value)
  end

  def set(key, _value)
    @setted_params << key
  end

  def unique(_key, _value)
    # don't do nothing
  end

  def log(text = '', type = :info)
    @data[:logs] << "[#{type}]: " + text.to_s
  end
end
