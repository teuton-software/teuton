# frozen_string_literal: true

require_relative "../application"

module ExportManager
  ##
  # Run export function
  # @param main_report (Report)
  # @param cases (Array)
  # @param input (Hash) Selected export options
  def self.run(main_report, cases, input)
    args = strings2symbols(input)

    # default :format=>:txt
    format = args[:format] || Application.instance.default[:format]
    mode = args[:mode] || :all

    # Step 1: Export case reports
    threads = []
    cases.each { |c| threads << Thread.new { c.export(format) } }
    threads.each(&:join)

    # Step 2: Export resume report
    main_report.export_resume(format)

    # Step 3: Preserve files if required
    preserve_files if args[:preserve] == true
  end

  ##
  # Convert Hash String values into Symbol values
  # @param input (Hash)
  private_class_method def self.strings2symbols(input)
    args = {}
    input.each_pair do |key, value|
      args[key] = if value.instance_of? String
        value.to_sym
      else
        value
      end
    end
    args
  end

  ##
  # Preserve output files for current project execution
  private_class_method def self.preserve_files
    app = Application.instance
    t = Time.now
    data = {year: t.year, month: t.month, day: t.day, hour: t.hour, min: t.min, sec: t.sec}
    subdir = format("%<year>s%<month>02d%<day>02d-" \
                    "%<hour>02d%<min>02d%<sec>02d", data)
    logdir = File.join(app.output_basedir, app.global[:tt_testname], subdir)
    srcdir = File.join(app.output_basedir, app.global[:tt_testname])
    puts "[INFO] Preserving files => #{logdir}"
    FileUtils.mkdir(logdir)
    Dir.glob(File.join(srcdir, "**.*")).each { |file| FileUtils.cp(file, logdir) }
  end
end
