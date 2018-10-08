
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

  def my_execute(cmd, encoding='UTF-8')
    output = []
    return output if Application.instance.debug
    begin
      text = `#{cmd}`
      unless encoding == 'UTF-8'
        ec = Encoding::Converter.new(encoding.to_s, 'UTF-8')
        text = ec.convert(text)
        puts "Enconding..."+text
      end
      output = text.split("\n")
    rescue Exception => e
      verbose '!'
      puts e
      puts('Local exec: ' + cmd)
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
