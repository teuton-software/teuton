# frozen_string_literal: true

require_relative '../application'

##
# ExportManager is used by CaseManager to export output reports
module ExportManager
  ##
  # Run export function
  # @param main_report (Report)
  # @param cases (Array)
  # @param args (Hash) Selected export options
  # rubocop: disable Metrics/AbcSize
  def self.run(main_report, cases, args)
    # default :mode=>:all, :format=>:txt
    format = args[:format] || Application.instance.default[:format]
    mode = args[:mode] || :all
    # Step 1: Export case reports
    if %i[details all].include? mode
      threads = []
      cases.each { |c| threads << Thread.new { c.export format } }
      threads.each(&:join)
    end
    # Step 2: Export resume report
    main_report.export_resume format if %i[resume all].include? mode
    # Step 3: Preserve files if required
    preserve_files if args[:preserve] == true
  end
  # rubocop:enable Metrics/AbcSize

  ##
  # Preserve output files for current project
  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Layout/LineLength
  private_class_method def self.preserve_files
    app = Application.instance
    t = Time.now
    data = { year: t.year, month: t.month, day: t.day,
             hour: t.hour, min: t.min, sec: t.sec }
    subdir = format('%<year>s%<month>02d%<day>02d-' \
                    '%<hour>02d%<min>02d%<sec>02d', data)
    logdir = File.join(app.output_basedir, app.global[:tt_testname], subdir)
    srcdir = File.join(app.output_basedir, app.global[:tt_testname])
    puts "[INFO] Preserving files => #{logdir}"
    FileUtils.mkdir(logdir)
    Dir.glob(File.join(srcdir, '**.*')).each { |file| FileUtils.cp(file, logdir) }
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Layout/LineLength
end
