# frozen_string_literal: true

require_relative '../application'

##
# ExportManager is used by CaseManager to export output reports)
module ExportManager
  ##
  # Run export function
  # @param main_report (Report)
  # @param cases (Array)
  # @param args (Hash) Selected export options
  def self.run(main_report, cases, args)
    # default :mode=>:all, :format=>:txt
    format = args[:format] || Application.instance.default[:format]
    mode = args[:mode] || :all
    # Export case reports
    if %i[details all].include? mode
      threads = []
      cases.each { |c| threads << Thread.new { c.export format } }
      threads.each(&:join)
    end
    # Export resume report
    main_report.export_resume format if %i[resume all].include? mode
  end
end
