
require_relative "teuton_host"

class Case
  def host(host = "localhost")
    TeutonHost.new(self, host)
  end
end
