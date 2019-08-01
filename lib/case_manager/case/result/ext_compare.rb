# frozen_string_literal: true

# This is an extension of Result class
class Result
  def eq(external)
    @expected = external

    case external.class.to_s
    when 'Fixnum'
      internal = @content[0].to_i
    when 'Float'
      internal = @content[0].to_f
    when 'String'
      internal = @content[0].to_s
    else
      internal = @content[0]
    end
    internal == external
  end

  def neq(external)
    @expected = "Not equal to #{external}"

    case external.class.to_s
    when 'Fixnum'
      internal = @content[0].to_i
    when 'Float'
      internal = @content[0].to_f
    else
      internal = @content[0]
    end
    internal != external
  end

  def ge(p_value)
    @expected = "Greater or equal to #{p_value}"
    return false if @content.nil? || @content[0].nil?

    l_value = @content[0]
    case p_value.class.to_s
    when 'Fixnum'
      l_value = @content[0].to_i
    when 'Float'
      l_value = @content[0].to_f
    end
    l_value >= p_value
  end

  def gt(p_value)
    @expected = "Greater than #{p_value}"
    return false if @content.nil? || @content[0].nil?

    l_value = @content[0]
    case p_value.class.to_s
    when 'Fixnum'
      l_value = @content[0].to_i
    when 'Float'
      l_value = @content[0].to_f
    end
    l_value > p_value
  end

  def le(p_value)
    @expected = "Lesser or equal to #{p_value}"

    return false if @content.nil? || @content[0].nil?

    l_value = @content[0]
    case p_value.class.to_s
    when 'Fixnum'
      l_value = @content[0].to_i
    when 'Float'
      l_value = @content[0].to_f
    end
    l_value <= p_value
  end

  def lt(p_value)
    @expected = "Lesser than #{p_value}"
    return false if @content.nil? || @content[0].nil?

    l_value = @content[0]
    case p_value.class.to_s
    when 'Fixnum'
      l_value = @content[0].to_i
    when 'Float'
      l_value = @content[0].to_f
    end
    l_value < p_value
  end

  alias eq?        eq
  alias equal      eq
  alias equal?     eq
  alias is_equal?  eq
  alias neq?       neq
  alias not_equal  neq
  alias not_equal? neq
  alias greater_or_equal  ge
  alias greater_or_equal? ge
  alias greater          gt
  alias greater_than     gt
  alias lesser_or_equal  le
  alias lesser_or_equal? le
  alias lesser  lt
  alias smaller lt
  alias lesser_than lt
end
