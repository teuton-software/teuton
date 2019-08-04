# Readme
# * target
# * goto
# * run
# * expect
# * unique
# * log
class Readme
  def target(desc, args = {})
    @action = { target: desc }
  end
  alias goal target

  def goto(host = :localhost, args = {})
    unless host == :localhost
      @getter << "#{host.to_s}_ip".to_sym
      @getter << "#{host.to_s}_username".to_sym
      @getter << "#{host.to_s}_password".to_sym
    end
    @action[:host] = host
    @action[:exec] = args[:exec]
  end

  def run(command, args = {})
    args[:exec] = command
    goto(:localhost, args)
  end

  def expect(cond, args = {})
    weight = 1.0
    weight = args[:weight].to_f if args[:weight]
    @action[:weight] = weight
    @current[:actions] << @action
    result.reset
  end
  alias expect_any expect
  alias expect_none expect
  alias expect_one expect

  def get(value)
    @getter << value
    value.to_s.upcase
  end

  def gett(value)
    @getter << value
    "VALUE (#{value})"
  end

  def set(key, value)
    @getter.delete(key)
    # don't do nothing
  end

  def unique(key, value)
    # don't do nothing
  end

  def log(text = '', type = :info)
    @data[:logs] << "[#{type}]: " + text.to_s
  end
end
