
class Service
  attr_accessor :param

  def initialize(parent)
    @parent = parent
  end

  def is_running?
    @parent.target("Service #{@param} is running?")
    @parent.run "systemctl status #{@param}"
    @parent.expect_one ['Active:', 'running' ]
  end
end
