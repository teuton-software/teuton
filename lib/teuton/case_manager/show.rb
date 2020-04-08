# frozen_string_literal: true

require_relative '../application'

# CaseManager show method
class CaseManager
  ##
  # Show cases and resume report data on screep
  # @param mode (Symbol) Values => :resume, :cases or :all
  def show(mode = :resume)
    return if Application.instance.quiet?

    # Show resume report data on screen
    @report.show if %i[resume all].include? mode

    # Show cases report data on screen
    return if mode == :resume

    @cases.each do |c|
      puts '=' * 40
      c.show
    end
  end
end
