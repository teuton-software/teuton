# frozen_string_literal: true

require_relative "getset"
require_relative "run"

module ReadmeDSL
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
    @action = {target: desc, host: previous_host, readme: []}
    weight = 1.0
    weight = args[:weight].to_f if args[:weight]
    @action[:weight] = weight
  end
  alias_method :goal, :target

  def expect(_cond, _args = {})
    @current[:actions] << @action
    result.reset
  end
  alias_method :expect_any, :expect
  alias_method :expect_first, :expect
  alias_method :expect_last, :expect
  alias_method :expect_one, :expect

  def expect_none(cond = nil)
    expect(cond)
  end
  alias_method :expect_nothing, :expect_none

  def unique(_key, _value)
    # don't do nothing
  end

  def log(text = "", type = :info)
    @data[:logs] << "[#{type}]: " + text.to_s
  end
end
