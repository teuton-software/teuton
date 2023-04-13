require "open3"
require "rainbow"
require_relative "../../utils/project"
require_relative "../../utils/verbose"

class ExecuteLocal
  include Verbose

  def initialize(parent)
    @parent = parent
    # READ: @config, cmd = action[:command]
    # WRITE: @action, @result, @session
    # my_execute, encode_and_split methods?
  end

  def call
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

  def run_cmd_localhost
    action[:conn_type] = :local
    resp = my_execute(action[:command], action[:encoding])
    result.exitcode = resp[:exitcode]
    result.content = resp[:content]
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
    return {exitstatus: 0, content: ""} if Project.debug?

    begin
      text, status = Open3.capture2e(cmd)
      exitstatus = status.exitstatus
    rescue => e
      verbose Rainbow("!").green
      text = e.to_s
      exitstatus = 1
    end
    content = encode_and_split(encoding, text)
    {exitstatus: exitstatus, content: content}
  end
end
