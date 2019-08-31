# Laboratory
# * target
# * request (development)
# * tempfile
# * goto
# * run
# * expect
# * get
# * unique
# * log
# * set
class Laboratory
  def target(desc, args = {})
    @stats[:targets] += 1
    @targetid += 1
    i = @targetid
    verboseln '(%03d' % i + ") target      #{desc}"
  end
  alias goal target

  def request(text)
    @requests << text.to_s
  end

  def tempfile(_tempfile = nil)
    'tempfile'
  end

  def goto(host = :localhost, args = {})
    result.reset

    if @hosts[host]
      @hosts[host] += 1
    else
      @hosts[host] = 1
    end
    verboseln "      goto        #{host} and #{args}"
  end

  def run(command, args = {})
    args[:exec] = command
    goto(:localhost, args)
  end

  def expect(_cond, args = {})
    if _cond.class == String or _cond.class == Array
      expect_one _cond, args
      return
    end
    weight = 1.0
    weight = args[:weight].to_f if args[:weight]
    verboseln "      alter       #{result.alterations}" unless result.alterations.empty?
    verboseln "      expect      #{result.expected} (#{result.expected.class})"
    verboseln "      weight      #{weight}"
    verboseln ''
  end

  def expect_one(_cond, args = {})
    weight = 1.0
    weight = args[:weight].to_f if args[:weight]
    verboseln "      expect_one  #{_cond.to_s} (#{_cond.class})"
    verboseln "      weight      #{weight}"
    verboseln ''
  end

  def expect_none(_cond, args = {})
    weight = 1.0
    weight = args[:weight].to_f if args[:weight]
    verboseln "      expect_none #{_cond.to_s} (#{_cond.class})"
    verboseln "      weight      #{weight}"
    verboseln ''
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

  def gett(option)
    value = get(option)
    value
  end

  def unique(key, _value)
    @stats[:uniques] += 1

    verboseln "    ! Unique      value for <#{key}>"
    verboseln ''
  end

  def log(text = '', type = :info)
    @stats[:logs] += 1
    verboseln "      log    [#{type}]: " + text.to_s
  end

  def set(key, value)
    @stats[:sets] += 1

    key = ':' + key.to_s if key.class == Symbol
    value = ':' + value.to_s if value.class == Symbol

    @sets[key] = value
    "set(#{key},#{value})"
  end
end
