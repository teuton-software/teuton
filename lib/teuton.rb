require_relative "teuton/utils/project"
require_relative "teuton/version"

module Teuton
  def self.create(path_to_new_dir)
    require_relative "teuton/skeleton"
    Skeleton.new.create(path_to_new_dir)
  end

  def self.check(projectpath, options = {})
    Project.add_input_params(projectpath, options)
    require_dsl_and_script("teuton/check/main")
    require_relative "teuton/check/checker"
    checker = Checker.new(
      Project.value[:script_path],
      Project.value[:config_path]
    )
    checker.show(options["onlyconfig"] || false)
  end

  def self.run(projectpath, options = {})
    Project.add_input_params(projectpath, options)
    require_dsl_and_script("teuton/case_manager/dsl")
  end

  def self.readme(projectpath, options = {})
    Project.add_input_params(projectpath, options)
    require_dsl_and_script("teuton/readme/main")
    readme = Readme.new(
      Project.value[:script_path],
      Project.value[:config_path]
    )
    readme.show
  end

  def self.server(projectpath)
    require_relative "teuton/config/server"
    ConfigServer.configure_project(projectpath)
  end

  private_class_method def self.require_dsl_and_script(dslpath)
    # Load DSL file and then load script file
    require_relative dslpath
    begin
      mainscriptfile = Project.value[:script_path]
      require_relative mainscriptfile
    rescue StandardError => e
      warn Rainbow("[ERROR] #{e}").bright.red
      e.backtrace&.first(3)&.each do |line|
        warn Rainbow("[ERROR]   #{line}").red
      end
      exit 1
    end
  end
end
