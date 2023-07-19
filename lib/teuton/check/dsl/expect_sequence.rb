module CheckDSL
  class ExpectSequence
    def initialize
      @expected = []
    end

    def is_valid?(&block)
      instance_eval(&block)
    end

    def expected
      @expected.join(">")
    end

    private

    def find(value)
      @expected << "find(#{value})"
    end

    def next_to(value)
      @expected << "next_to(#{value})"
    end

    def ignore(value)
      @expected << "ignore(#{value})"
    end
  end
end
