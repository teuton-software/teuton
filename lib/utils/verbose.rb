
require_relative '../application'

# Define general use methods
module Verbose
  def verboseln(text)
    verbose(text + "\n")
  end

  def verbose(text)
    return unless Application.instance.verbose
    return if Application.instance.options['quiet']
    print text
  end
end
