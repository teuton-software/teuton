# frozen_string_literal: true

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
    weight = 1.0
    weight = args[:weight].to_f if args[:weight]
    @action[:weight] = weight
  end
  alias goal target

  def goto(host = :localhost, args = {})
    unless host == :localhost
      @getter << "#{host}_ip".to_sym
      @getter << "#{host}_username".to_sym
      @getter << "#{host}_password".to_sym
    end
    @action[:host] = host
    @action[:exec] = args[:exec]
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
    @getter << value
    value.to_s.upcase
  end

  def gett(value)
    @getter << value
    "VALUE (#{value})"
  end

  def set(key, _value)
    @getter.delete(key)
  end

  def unique(_key, _value)
    # don't do nothing
  end

  def log(text = '', type = :info)
    @data[:logs] << "[#{type}]: " + text.to_s
  end
end
