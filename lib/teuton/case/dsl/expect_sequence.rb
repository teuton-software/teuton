class ExpectSequence
  def initialize(lines)
    @lines = lines
    @alterations = []
  end

  def is_valid?(&block)
    @indexes = []
    instance_eval(&block)
    @indexes == @indexes.sort
  end

  def find(value)
    found = 9999
    @lines.each_with_index do |line, index|
      if line.include? value
        @alterations << "find(#{value})"
        found = index
        break
      end
    end
    @indexes << found
  end

  def alterations
    @alterations.join(" then ")
  end
end
