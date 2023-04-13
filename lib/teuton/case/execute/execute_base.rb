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
end
