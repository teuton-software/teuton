require_relative "teuton_file"
require_relative "package"
require_relative "service"
require_relative "user"

class TeutonHost
  attr_reader :parent
  attr_reader :host

  def initialize(parent, host = "localhost")
    @parent = parent
    @host = host
  end

  def file(param)
    TeutonFile.new(self, param)
  end

  def package(param)
    Package.new(self, param)
  end

  def service(param)
    Service.new(self, param)
  end

  def user(param)
    User.new(self, param)
  end
end
