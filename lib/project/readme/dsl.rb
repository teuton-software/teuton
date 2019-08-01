# Readme
# * target
# * goto
# * run
# * expect
# * unique
# * log
class Readme
  def target(desc, args = {})
    @current_group << @current
    @current = {}
    @current[:target] = desc
  end
  alias goal target

  def goto(host = :localhost, args = {})
    @current[:goto] = "#{host} and #{args}"
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
    @current[:expect] = "any #{_cond.to_s} (#{_cond.class})"
    weight = 1.0
    weight = args[:weight].to_f if args[:weight]
    @current[:weight] = weight
  end

  def expect_one(_cond, args = {})
    @current[:expect] =  "one  #{_cond.to_s} (#{_cond.class})"
    weight = 1.0
    weight = args[:weight].to_f if args[:weight]
    @current[:weight] = weight
  end

  def expect_none(_cond, args = {})
    @current[:expect] = "none #{_cond.to_s} (#{_cond.class})"
    weight = 1.0
    weight = args[:weight].to_f if args[:weight]
    @current[:weight] = weight
  end

  def unique(key, _value)
    # don't do nothing
  end

  def log(text = '', type = :info)
    @current_group[:logs] << "[#{type}]: " + text.to_s
  end
end
