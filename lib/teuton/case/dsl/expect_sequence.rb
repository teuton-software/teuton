class ExpectSequence
  def initialize(lines)
    @lines = lines
  end

  def is_valid?(&block)
    @expected = []
    @real = []
    @current_state = true
    @last_index = -1
    instance_eval(&block)
    @current_state
  end

  def expected
    @expected.join(" then ")
  end

  def real
    @real.join(" then ")
  end

  private

  def find(value)
    @expected << "find(#{value})"
    index = get_index_of(value)

    if index > @last_index
      @real << "find(#{value})"
      @last_index = index
      return
    end

    @real << "no find(#{value})"
    @current_state = false
  end

  def followed_by(value)
    @expected << "followed_by(#{value})"

    line = @lines[@last_index + 1]
    if line.include? value
      @real << "followed_by(#{value})"
      @last_index += 1
      return
    end
    @real << "no followed_by(#{value})"
    index = get_index_of(value)
    @last_index = index unless index.nil?
    @current_state = false
  end

  def get_index_of(value)
    @lines.each_with_index do |line, index|
      return index if line.include? value
    end
    nil
  end
end
