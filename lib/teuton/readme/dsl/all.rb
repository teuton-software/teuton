# frozen_string_literal: true

require_relative "expect"
require_relative "getset"
require_relative "run"

module ReadmeDSL
  def readme(text)
    if @action[:target].nil?
      @current[:readme] << text # It's a group readme
    else
      @action[:readme] << text # It's a target readme
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

  def unique(_key, _value)
    # Nothing to do
  end

  def log(text = "", type = :info)
    # Nothing to do
  end
end
