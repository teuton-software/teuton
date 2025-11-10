class ExpectSequence
  attr_reader :result, :states

  def initialize(lines)
    @lines = lines
  end

  def is_valid?(&block)
    @expected = []
    @states = [
      { last_index: -1, steps: [], found: [] }
    ]
    instance_eval(&block)
    @result = find_best_state
    @result[:ok]
  end

  def expected
    @expected.join(">")
  end

  def real
    # From final result return evaluation progress
    text = []
    @result[:steps].each do |step|
      index = text.size
      text << if step
                @expected[index]
              else
                "not #{@expected[index]}"
              end
    end
    text.join(">")
  end

  private

  def find_best_state
    @states.each do |state|
      state[:score] = state[:steps].count { _1 }
      state[:fails] = state[:steps].count { !_1 }
      state[:ok] = state[:fails].zero?
    end
    best = @states[0]
    @states.each { |state| best = state if state[:score] > best[:score] }
    best
  end

  def find(value)
    @expected << "find(#{value})"
    newstates = []
    @states.each do |state|
      last_index = state[:last_index]

      if last_index > (@lines.size - 1)
        steps = state[:steps].clone
        steps << false
        newstates << {
          last_index: last_index,
          steps: steps,
          found: state[:found].clone
        }
        next
      end

      findindexes = get_indexes(value: value, from: last_index)
      findindexes.each do |findindex|
        found = state[:found].clone
        found << findindex
        steps = state[:steps].clone
        steps << true
        newstates << {
          last_index: findindex,
          steps: steps,
          found: found
        }
      end
    end
    @states = if newstates.size.zero?
                @states.each { |state| state[:steps] << false }
              else
                newstates
              end
  end

  def next_to(value)
    @expected << "next_to(#{value})"
    newstates = []

    @states.each do |state|
      last_index = state[:last_index]

      if last_index > (@lines.size - 1)
        steps = state[:steps].clone
        steps << false
        newstates << {
          last_index: last_index,
          steps: steps,
          found: state[:found].clone
        }
        next
      end

      last_index += 1
      found = state[:found].clone
      steps = state[:steps].clone
      line = @lines[last_index]
      if line.include?(value)
        found << last_index
        steps << true
      else
        steps << false
      end
      newstates << {
        last_index: last_index,
        steps: steps,
        found: found
      }
    end
    @states = if newstates.size.zero?
                @states.each { |state| state[:steps] << false }
              else
                newstates
              end
  end

  def ignore(value)
    @expected << "ignore(#{value})"
    newstates = []
    @states.each do |state|
      last_index = state[:last_index] + value.to_i

      steps = state[:steps].clone
      steps << !(last_index > (@lines.size - 1))

      newstates << {
        last_index: last_index,
        steps: steps,
        found: state[:found].clone
      }
    end

    @states = if newstates.size.zero?
                @states.each { |state| state[:steps] << false }
              else
                newstates
              end
  end

  def get_indexes(value:, from:)
    indexes = []

    @lines.each_with_index do |line, index|
      next if index < from

      indexes << index if line_include_value?(line: line, value: value)
    end
    indexes
  end

  def line_include_value?(line:, value:)
    if value.is_a? String
      return true if line.include? value
    elsif value.is_a? Regexp
      return true << index if value.match(line)
    else
      puts "[ERROR] expect_sequence #{value.class}"
      exit 1
    end
    false
  end
end
