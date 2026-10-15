module Teuton
  class Error < StandardError; end
  class ConfigurationError < Error; end
  class ExecutionError < Error; end
  class InputError < Error; end
end
