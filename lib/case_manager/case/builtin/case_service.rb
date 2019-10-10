
require_relative 'service'

class Case
  def service(param)
    @service = Service.new(self) if @service.nil?
    @service.param = param
    @service
  end
end
