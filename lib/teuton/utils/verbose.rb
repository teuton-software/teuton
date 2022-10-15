require_relative "../application"

module Verbose
  def verboseln(text)
    verbose(text + "\n")
  end

  def verbose(text)
    return if Application.instance.quiet?

    print text
  end
end
