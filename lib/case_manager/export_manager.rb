# frozen_string_literal: true

require_relative '../application'

# ExportManager#export
module ExportManager
  def self.run(main_report, cases, args)
    # default :mode=>:all, :format=>:txt
    format = args[:format] || Application.instance.default[:format]
    mode = args[:mode] || :all
    # Export resume report
    main_report.export_resume format if %i[resume all].include? mode
    return unless %i[details all].include? mode

    threads = []
    cases.each { |c| threads << Thread.new { c.export format } }
    threads.each(&:join)
  end
end
