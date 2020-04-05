# frozen_string_literal: true

require_relative '../application'

# CaseManager#show
class CaseManager
  def show(mode = :resume)
    return if Application.instance.quiet?

    if %i[resume all].include? mode
      @report.show
    elsif %i[cases all].include? mode
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
