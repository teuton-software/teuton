# frozen_string_literal: true

# This is an extension of Result class
# rubocop:disable Metrics/ClassLength
class Result
  # rubocop:disable Metrics/MethodLength
  # Return true when content is equal than input
  # @param input (Object)
  def eq(input)
    @expected = input

    case input.class.to_s
    when 'Fixnum'
      value = @content[0].to_i
      puts '[WARN] Fixnum class is deprecated!'
      puts '       Upgrade your Ruby version.'
    when 'Float'
      value = @content[0].to_f
    when 'Integer'
      value = @content[0].to_i
    when 'String'
      value = @content[0].to_s
    else
      value = @content[0]
    end
    value == input
  end
  # rubocop:enable Metrics/MethodLength
  alias eq?        eq
  alias equal      eq
  alias equal?     eq
  alias is_equal?  eq

  # rubocop:disable Metrics/MethodLength
  def neq(external)
    @expected = "Not equal to #{external}"

    case external.class.to_s
    when 'Fixnum'
      internal = @content[0].to_i
      puts '[WARN] Fixnum class is deprecated!'
      puts '       Upgrade your Ruby version.'
    when 'Float'
      internal = @content[0].to_f
    when 'Integer'
      internal = @content[0].to_i
    else
      internal = @content[0]
    end
    internal != external
  end
  # rubocop:enable Metrics/MethodLength
  alias neq?       neq
  alias not_equal  neq
  alias not_equal? neq

  # rubocop:disable Metrics/MethodLength
  def ge(input)
    @expected = "Greater or equal to #{input}"
    return false if @content.nil? || @content[0].nil?

    value = @content[0]
    case input.class.to_s
    when 'Fixnum'
      value = @content[0].to_i
      puts '[WARN] Fixnum class is deprecated!'
      puts '       Upgrade your Ruby version.'
    when 'Float'
      value = @content[0].to_f
    when 'Integer'
      value = @content[0].to_i
    end
    value >= input
  end
  # rubocop:enable Metrics/MethodLength
  alias greater_or_equal  ge
  alias greater_or_equal? ge

  # rubocop:disable Metrics/MethodLength
  def gt(input)
    @expected = "Greater than #{input}"
    return false if @content.nil? || @content[0].nil?

    value = @content[0]
    case input.class.to_s
    when 'Fixnum'
      value = @content[0].to_i
      puts '[WARN] Fixnum class is deprecated!'
      puts '       Upgrade your Ruby version.'
    when 'Float'
      value = @content[0].to_f
    when 'Integer'
      value = @content[0].to_i
    end
    value > input
  end
  # rubocop:enable Metrics/MethodLength
  alias greater          gt
  alias greater_than     gt

  # rubocop:disable Metrics/MethodLength
  def le(input)
    @expected = "Lesser or equal to #{input}"

    return false if @content.nil? || @content[0].nil?

    value = @content[0]
    case input.class.to_s
    when 'Fixnum'
      value = @content[0].to_i
      puts '[WARN] Fixnum class is deprecated!'
      puts '       Upgrade your Ruby version.'
    when 'Float'
      value = @content[0].to_f
    when 'Integer'
      value = @content[0].to_i
    end
    value <= input
  end
  # rubocop:enable Metrics/MethodLength
  alias lesser_or_equal  le
  alias lesser_or_equal? le

  # rubocop:disable Metrics/MethodLength
  def lt(input)
    @expected = "Lesser than #{input}"
    return false if @content.nil? || @content[0].nil?

    value = @content[0]
    case input.class.to_s
    when 'Fixnum'
      value = @content[0].to_i
      puts '[WARN] Fixnum class is deprecated!'
      puts '       Upgrade your Ruby version.'
    when 'Float'
      value = @content[0].to_f
    when 'Integer'
      value = @content[0].to_i
    end
    value < input
  end
  # rubocop:enable Metrics/MethodLength
  alias lesser  lt
  alias smaller lt
  alias lesser_than lt

  # Return 'true' if the parameter value is near to the target value.
  # To get this we consider a 10% desviation or less, as an acceptable result.
  def near_to?(input)
    @expected = "Is near to #{input}"
    return false if @content.nil?

    target = @content[0].to_f
    desv   = (target * 10.0) / 100.0
    return true if (target - input.to_f).abs.to_f <= desv

    false
  end
  alias near_to near_to?
  alias near? near_to?
  alias near near_to?
end
# rubocop:enable Metrics/ClassLength
