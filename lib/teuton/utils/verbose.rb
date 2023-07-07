require_relative "project"

module Verbose
  def verboseln(text)
    verbose(text.to_s + "\n")
  end

  def verbose(text)
    return if Project.quiet?

    print text
  end
end
