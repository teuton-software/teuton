module Teuton
  class Error < StandardError; end
  class ConfigurationError < Error; end
  class ExecutionError < Error; end
  class InputError < Error; end

  class MainScriptNotFoundError < Error
    attr_reader :script_path

    def initialize(script_path)
      @script_path = script_path
      super(build_message)
    end

    private

    def build_message
      <<~MSG.strip
        Main script file not found!
        - Not found '#{script_path}'
      MSG
    end
  end
end
