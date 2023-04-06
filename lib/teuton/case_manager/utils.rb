require_relative "../application"
require "fileutils"

module Utils
  def ensure_dir(dirname)
    # Create the directory if it dosn't exist.
    unless Dir.exist?(dirname)
      FileUtils.mkdir_p(dirname)
      return false
    end
    true
  end

  def encode_and_split(encoding, text)
    # Convert text to UTF-8 deleting unknown chars
    text ||= "" # Ensure text is not nil
    flag = [:default, "UTF-8"].include? encoding
    return text.encode("UTF-8", invalid: :replace).split("\n") if flag

    # Convert text from input ENCODING to UTF-8
    ec = Encoding::Converter.new(encoding.to_s, "UTF-8")
    begin
      text = ec.convert(text)
    rescue => e
      puts "[ERROR] #{e}: Declare text encoding..."
      puts "        run 'command', on: :host, :encoding => 'ISO-8859-1'"
    end

    text.split("\n")
  end

  def my_execute(cmd, encoding = "UTF-8")
    return {exitstatus: 0, content: ""} if Application.instance.debug

    begin
      text = `#{cmd}`
      exitstatus = $CHILD_STATUS.exitstatus
    rescue => e
      verbose "F"
      exitstatus = $CHILD_STATUS.exitstatus
      text = e.to_s
    end
    content = encode_and_split(encoding, text)
    {exitstatus: exitstatus, content: content}
  end

  def verboseln(text)
    verbose(text + "\n")
  end

  def verbose(text)
    return if Application.instance.quiet?

    print text
  end
end
