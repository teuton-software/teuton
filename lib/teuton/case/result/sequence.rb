class Sequence
  def initialize(lines)
    @lines = lines
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
        found = value
        break
      end
    end
    @indexes << found
  end
end
