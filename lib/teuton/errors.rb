module Teuton
  class Error < StandardError; end

  class CaseManagerDslError < Error
    attr_reader :original_error, :filename

    def initialize(original_error, filename)
      @original_error = original_error
      @filename = filename
      super(build_message)
    end

    private

    def build_message
      <<~MSG.strip
        case_manager/dsl: #{@original_error}
        File not found! Fix line <use '#{@filename}'>
      MSG
    end
  end

  class ConfigurationError < Error; end

  class ConfigFileError < Error
    attr_reader :filepath, :original_error

    def initialize(filepath, original_error)
      @filepath = filepath
      @original_error = original_error
      super(build_message)
    end

    private

    def build_message
      <<~MSG.strip
        Reading configurations file:
        - File : #{@filepath}
        - Type : #{@original_error}
      MSG
    end
  end

  class InputError < Error; end
  class ExecutionError < Error; end

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

  class UploadArgumentError < ArgumentError; end
end
