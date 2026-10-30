# frozen_string_literal: true

# DSL#target
module DSL
  def doc(_text)
    # Usefull when running.
    # It's works only with "teuton reamde" command action.
  end

  def readme(...)
    Logger.warn("Keyword deprecated: Replace 'readme' by 'doc'.")
    doc(...)
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
