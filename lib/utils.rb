
require_relative 'application'

# Define general use methods
module Utils
  # Create the directory if it dosn't exist.
  def ensure_dir(dirname)
    unless Dir.exist?(dirname)
      FileUtils.mkdir_p(dirname)
      return false
    end
    true
  end

  def my_execute(cmd)
    output = []
    return output if Application.instance.debug
    begin
      text = `#{cmd}`
      output = text.split("\n")
    rescue
      verbose '!'
      log('Local exec: ' + cmd)
    end
    output
  end

  def verboseln(text)
    verbose(text + "\n")
  end

  def verbose(text)
    return unless Application.instance.verbose
    print text
  end
end
