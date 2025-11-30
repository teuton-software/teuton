# frozen_string_literal: true

require "rainbow"
require_relative "../utils/project"
require_relative "../report/formatter/formatter"

##
# Execute "export" order: Export every case report
# @param args (Hash) Export options
class ExportManager
  ##
  # Run export function
  # @param main_report (Report)
  # @param cases (Array)
  # @param input (Hash) Selected export options
  def call(main_report, cases, args)
    if args.class != Hash
      puts Rainbow("[ERROR] ExportManager: argument error!").red
      puts Rainbow("[ERROR] Fix line <export #{args}>").red
      puts Rainbow("[ERROR] Replace by <export format: 'txt'>").red
      puts ""
      exit 1
    end

    # Step 1: Validate options
    options = strings2symbols(args)
    if options[:format].nil?
      options[:format] = Project.value[:format]
    end

    unless Formatter.available_formats.include? options[:format]
      puts Rainbow("[WARN] ExportManager: Unkown format!").yellow.bright
      puts Rainbow("[WARN] Fix line <export format: #{options[:format]}>").yellow.bright
      puts Rainbow("[INFO] Available formats: #{Formatter.available_formats.join(", ")}.").white.bright
      puts Rainbow("[INFO] Using default format <txt>.").white.bright
      options[:format] = :txt
    end

    # Step 2: Export case reports
    binding.break
    if Project.value[:global][:tt_sequence]
      cases.each { |c| c.export(options) }
    else
      threads = []
      cases.each { |c| threads << Thread.new { c.export(options) } }
      threads.each(&:join)
    end

    # Step 3: Export resume report
    main_report.export_resume(options)

    # Step 4: Preserve files if required
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
    preserve_dir = File.join(srcdir, subdir)

    puts "[INFO] Preserving files => #{preserve_dir}"
    FileUtils.mkdir(preserve_dir)
    Dir.glob(File.join(srcdir, "**.*")).each { |file| FileUtils.cp(file, preserve_dir) }
  end
end
