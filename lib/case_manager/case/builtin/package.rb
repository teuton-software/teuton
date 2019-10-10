
class Package
  attr_accessor :param

  def initialize(parent)
    @parent = parent
  end

  def installed?
    @parent.target("Package #{@param} installed?")
    @parent.run "whereis #{@param}"
    @parent.expect_one [ 'bin', @param ]
  end

  def not_installed?
    @parent.target("Package #{@param} not installed?")
    @parent.run "whereis #{@param}"
    @parent.expect_none [ 'bin' , @param ]
  end
end
