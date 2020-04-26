
require_relative 'package'
require_relative 'service'
require_relative 'user'

class Case
  def package(param, host = 'localhost')
    @package = @package || Package.new(self, host)
    @package.param = param
    @package
  end

  def service(param, host = 'localhost')
    @service = @service || Service.new(self, host)
    @service.param = param
    @service
  end

  def user(param, host = 'localhost')
    @user = @user || User.new(self, host)
    @user.param = param
    @user
  end
end
