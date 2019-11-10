
require_relative 'package'
require_relative 'service'
require_relative 'user'

class Case
  def package(param)
    @package = @package || Package.new(self)
    @package.param = param
    @package
  end

  def service(param)
    @service = @service || Service.new(self)
    @service.param = param
    @service
  end

  def user(param)
    @user = @user || User.new(self)
    @user.param = param
    @user
  end
end
