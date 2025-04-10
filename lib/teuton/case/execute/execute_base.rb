require_relative "../../utils/verbose"

class ExecuteBase
  include Verbose

  def initialize(parent)
    @parent = parent
    # READ: @config, cmd = action[:command]
    # WRITE: @action, @result, @session
  end

  private

  def config
    @parent.config
  end

  def action
    @parent.action
  end

  def result
    @parent.result
  end

  def sessions
    @parent.sessions
  end

  def log(...)
    @parent.log(...)
  end

  def conn_status
    @parent.conn_status
  end

  def encode_and_split(encoding, text)
    # Convert text to UTF-8 deleting unknown chars
    text ||= "" # Ensure text is not nil

    # TODO: text.gsub!('\r', '')
    if [:default, "UTF-8"].include? encoding
      text.encode!("UTF-8", invalid: :replace, undef: :replace, replace: "")
      return text.split("\n")
    end

    # Convert text from input ENCODING to UTF-8
    ec = Encoding::Converter.new(encoding.to_s, "UTF-8")
    begin
      text = ec.convert(text)
    rescue => e
      puts "[ERROR] #{e}: Declare text encoding..."
      puts "        run 'command', on: :host, encoding: 'ISO-8859-1'"
    end

    text.split("\n").compact
  end
end
