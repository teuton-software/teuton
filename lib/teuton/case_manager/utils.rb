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

  # rubocop:disable Metrics/MethodLength
  def encode_and_split(encoding, text)
    # Convert text to UTF-8 deleting unknown chars
    text ||= '' # Ensure text is not nil
    flag = [:default, 'UTF-8'].include? encoding
    return text.encode('UTF-8', invalid: :replace).split("\n") if flag

    # Convert text from input ENCODING to UTF-8
    ec = Encoding::Converter.new(encoding.to_s, 'UTF-8')
    begin
      text = ec.convert(text)
    rescue StandardError => e
      puts "[ERROR] #{e}: Declare text encoding..."
      puts "        goto :host, :exec => 'command', :encoding => 'ISO-8859-1'"
    end

    text.split("\n")
  end
  # rubocop:enable Metrics/MethodLength

  def my_execute(cmd, encoding = 'UTF-8')
    return { exitstatus: 0, content: '' } if Application.instance.debug

    begin
      text = `#{cmd}`
      exitstatus = $CHILD_STATUS.exitstatus
    rescue StandardError => e # rescue Exception => e
      verbose '!'
      puts("[ERROR] #{e}: Local exec: #{cmd}")
    end
    content = encode_and_split(encoding, text)
    { exitstatus: exitstatus, content: content }
  end

  def verboseln(text)
    verbose(text + "\n")
  end

  def verbose(text)
    return if Application.instance.quiet?

    print text
  end
end
