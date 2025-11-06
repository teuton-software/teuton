# frozen_string_literal: true

require "rainbow"
require_relative "../utils/project"

##
# Execute "export" order: Export every case report
# @param args (Hash) Export options
class ExportManager
  ##
  # Run export function
  # @param main_report (Report)
  # @param cases (Array)
  # @param input (Hash) Selected export options
  def call(main_report, cases, args, default_format)
    if args.class != Hash
      puts Rainbow("[ERROR] Export argument error!").red
      puts Rainbow("  Revise: export #{args}").red
      puts Rainbow("  Use   : export format: 'txt'").red
      puts ""
      exit 1
    end

    options = strings2symbols(args)
    if options[:format].nil?
      options[:format] = default_format
    end

    # Step 1: Export case reports
    threads = []
    cases.each { |c| threads << Thread.new { c.export(options) } }
    threads.each(&:join)

    # Step 2: Export resume report
    main_report.export_resume(options)

    # Step 3: Preserve files if required
    preserve_files if options[:preserve] == true
  end

  private

  ##
  # Convert Hash String values into Symbol values
  # @param input (Hash)
  def strings2symbols(input)
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
  def preserve_files
    srcdir = File.join(
      Project.value[:output_basedir],
      Project.value[:test_name]
    )

    t = Time.now
    data = {
      year: t.year, month: t.month, day: t.day,
      hour: t.hour, min: t.min, sec: t.sec
    }
    subdir = format("%<year>s%<month>02d%<day>02d-" \
                    "%<hour>02d%<min>02d%<sec>02d", data)
    logdir = File.join(srcdir, subdir)

    puts "[INFO] Preserving files => #{logdir}"
    FileUtils.mkdir(logdir)
    Dir.glob(File.join(srcdir, "**.*")).each { |file| FileUtils.cp(file, logdir) }
  end
end
