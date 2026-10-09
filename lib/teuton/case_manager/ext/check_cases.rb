require "fileutils"
require_relative "hall_of_fame"
require_relative "../../case/case"
require_relative "../../utils/config_file_reader"
require_relative "../../utils/project"
require "debug"

module CheckCasesExtension
  def check_cases!
    # Start checking every single case
    app = Project.value
    # Load configurations from config file
    configdata = ConfigFileReader.call(Project.value[:config_path])
    app[:ialias] = configdata[:alias]
    app[:global] = configdata[:global]
    app[:global][:tt_sequence] = false if app[:global][:tt_sequence].nil?

    app[:test_name] = app[:global][:tt_test_name] if app[:global][:tt_test_name]
    app[:output_dir] = (app[:global][:tt_output_dir] || File.join(app[:output_basedir], app[:test_name]))

    # Create out dir
    output_dir = app[:output_dir]
    FileUtils.mkdir_p(output_dir) unless Dir.exist?(output_dir)
    @report.output_dir = output_dir

    # Fill report head
    open_main_report(app[:config_path])

    # create cases and run
    configdata[:cases].each { |config| @cases << Case.new(config) }
    start_time = run_all_cases # run cases

    # TODO: merge these 2 methdos
    # TODO: CloseManager.call ???
    uniques = collect_uniques_for_all_cases
    close_reports_for_all_cases(uniques)
    close_main_report(start_time)
  end

  def run_all_cases
    start_time = Time.now
    verboseln Rainbow("-" * 36).green
    verboseln Rainbow("Started at #{start_time}").green
    # if Application.instance.global[:tt_sequence] == true
    if Project.value[:global][:tt_sequence] == true
      # Run every case in sequence
      @cases.each(&:play)
    else
      # Run all cases in parallel
      threads = []
      @cases.each { |c| threads << Thread.new { c.play } }
      threads.each(&:join)
    end
    start_time
  end

  ##
  # Collect uniques values for all cases
  def collect_uniques_for_all_cases
    uniques = {} # Collect "unique" values from all cases
    @cases.each do |c|
      c.uniques.each do |key|
        if uniques[key].nil?
          uniques[key] = [c.id]
        else
          uniques[key] << c.id
        end
      end
    end
    uniques
  end

  ##
  # 1) Reevaluate every case with collected unique values
  # 2) Close all case reports
  # 3) And order to build hall of fame
  def close_reports_for_all_cases(uniques)
    threads = []
    @cases.each { |c| threads << Thread.new { c.close uniques } }
    threads.each(&:join)

    HallOfFame.new(@cases).call
  end
end
