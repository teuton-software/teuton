# frozen_string_literal: true

require_relative '../application'

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

  def encode_and_split(encoding, text)
    # Convert text to UTF-8 deleting unknown chars
    flag = [:default, 'UTF-8'].include? encoding
    return text.encode('UTF-8', invalid: :replace).split("\n") if flag

    # Convert text to UTF-8 when we know encoding
    ec = Encoding::Converter.new(encoding.to_s, 'UTF-8')
    begin
      text = ec.convert(text)
    rescue StandardError => e
      puts "[ERROR] #{e}: Declare text encoding..."
      puts "        goto :host, :exec => 'command', :encoding => 'ISO-8859-1'"
    end

    text.split("\n")
  end

  def my_execute(cmd, encoding = 'UTF-8')
    text = ''
    return output if Application.instance.debug

    begin
      text = `#{cmd}`
    rescue StandardError => e # rescue Exception => e
      verbose '!'
      puts("[ERROR] #{e}: Local exec: #{cmd}")
    end
    encode_and_split(encoding, text)
  end

  def verboseln(text)
    verbose(text + "\n")
  end

  def verbose(text)
    return unless Application.instance.verbose

    print text
  end
end
