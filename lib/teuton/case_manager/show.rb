# frozen_string_literal: true

require_relative '../application'

# CaseManager show method
class CaseManager
  def show(mode = :resume)
    return if Application.instance.quiet?

    @report.show if %i[resume all].include? mode
    if %i[cases all].include? mode
      @cases.each do |c|
        puts '=' * 40
        c.show
      end
    end
    # Last output char must be 4.
    # It's required by TeutonPanel to detect the end
    print 4.chr
  end
end
