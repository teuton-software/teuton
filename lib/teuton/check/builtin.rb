#
# EXPERIMENTAL class
class Builtin
  attr_accessor :param

  def initialize(parent)
    @parent = parent
  end

  def method_missing(method)
    @parent.log "BUILTIN #{method}"
  end

  def respond_to_missing?(_method, *)
    true
  end
end

# Laboratory
# * service
class Laboratory
  def service(param)
    log "BUILTIN service(#{param})"
    @builtin ||= Builtin.new(self)
    @builtin.param = param
    @builtin
  end
end
