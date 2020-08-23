
class Package
  def initialize(teuton_host, param)
    @teuton_host = teuton_host
    @parent = teuton_host.parent
    @host = teuton_host.host
    @param = param
  end

  def installed?
    @parent.target("Package #{@param} installed?")
    @parent.run "whereis #{@param}", on: @host
    @parent.expect_one [ 'bin', @param ]
  end

  def not_installed?
    @parent.target("Package #{@param} not installed?")
    @parent.run "whereis #{@param}", on: @host
    @parent.expect_none [ 'bin' , @param ]
  end
end
