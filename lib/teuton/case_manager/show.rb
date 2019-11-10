# frozen_string_literal: true
require_relative '../application'

# CaseManager#show
class CaseManager
  def show(mode = :resume)
    return if Application.instance.quiet?

    @report.show if %i[resume all].include? mode

    return unless %i[details all].include? mode

    @cases.each do |c|
      puts '____'
      c.show
    end
    puts '.'
  end
end
