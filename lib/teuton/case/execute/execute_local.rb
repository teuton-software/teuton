require "open3"
require "rainbow"
require_relative "../../utils/project"
require_relative "../../utils/verbose"
require_relative "execute_base"

class ExecuteLocal < ExecuteBase
  def call
    action[:conn_type] = :local
    resp = my_execute(action[:command], action[:encoding])
    result.exitcode = resp[:exitcode]
    result.content = resp[:content]
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
