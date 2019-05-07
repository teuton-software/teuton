
# This is an extension of Result class
class Result
  def eq(p_value)
    @expected = p_value

    case p_value.class.to_s
    when 'Fixnum'
      l_value = @content[0].to_i
    when 'Float'
      l_value = @content[0].to_f
    when 'String'
      l_value = @content[0].to_s
    else
      l_value = @content[0]
    end
    l_value == p_value
  end

  def neq(p_value)
    @expected = "Not equal to #{p_value}"

    case p_value.class.to_s
    when 'Fixnum'
      l_value = @content[0].to_i
    when 'Float'
      l_value = @content[0].to_f
    else
      l_value = @content[0]
    end
    l_value != p_value
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
