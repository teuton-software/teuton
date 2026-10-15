module Teuton
  class Error < StandardError; end
  class ConfigurationError < Error; end
  class ExecutionError < Error; end
  class InputError < Error; end

  class ExportArgumentError < Error
    attr_reader :args

    def initialize(args)
      @args = args
      super(build_message)
    end

    private

    def build_message
      <<~MSG.strip
        ExportManager: argument error!
        - Fix line <export #{@args}>
        - Replace by <export format: 'txt'>
      MSG
    end
  end

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
        - File: #{script_path}
      MSG
    end
  end

  class UnexpectedSequenceTypeError < Error
    attr_reader :received_class

    def initialize(value_class)
      super("expect_sequence #{value_class}")
    end
  end
end
