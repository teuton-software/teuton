# frozen_string_literal: true

# DSL#target
module DSL
  def readme(_text)
    # Usefull when running.
    # It's works only with "teuton reamde" command action.
  end

  def target(desc, args = {})
    @action.description = desc.to_s
    w = args[:weight] || 1.0
    weight(w)
  end

  def goal(...)
    Logger.warn("Keyword deprecated: Replace 'goal' by 'target'.")
    target(...)
  end
end
