
class Service
  attr_accessor :param

  def initialize(parent, host = 'localhost')
    @parent = parent
    @host = host
  end

  def is_running?
    @parent.target("Service #{@param} is running?")
    @parent.run "systemctl status #{@param}", on: @host
    @parent.expect_one ['Active:', 'running' ]
  end

  def is_inactive?
    @parent.target("Service #{@param} is inactive?")
    @parent.run "systemctl status #{@param}", on: @host
    @parent.expect_one ['Active:', 'inactive' ]
  end

  def is_enable?
    @parent.target("Service #{@param} is enable?")
    @parent.run "systemctl status #{@param}", on: @host
    @parent.expect_one ['Loaded:', 'enable' ]
  end

  def is_disable?
    @parent.target("Service #{@param} is disable?")
    @parent.run "systemctl status #{@param}", on: @host
    @parent.expect_one ['Loaded:', 'disable' ]
  end
end
