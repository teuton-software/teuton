require "open3"
require "rainbow"
require_relative "../../utils/project"
require_relative "../../utils/verbose"
require_relative "execute_base"

class ExecuteLocal < ExecuteBase
  include Verbose

  def call
    action[:conn_type] = :local
    response = my_execute(action[:command], action[:encoding])
    result.exitcode = response[:exitcode]
    result.content = response[:content]
  end

  def my_execute(cmd, encoding = "UTF-8")
    return {exitcode: 0, content: ""} if Project.debug?

    begin
      text, status = Open3.capture2e(cmd)
      exitcode = status.exitstatus
    rescue => e
      text = e.to_s
      log("cmd=<#{cmd}> => #{text}", :error)
      exitcode = 1
      verbose Rainbow("!").green
    end
    content = encode_and_split(encoding, text)
    {exitcode: exitcode, content: content}
  end
end
