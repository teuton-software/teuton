require_relative "teuton/utils/project"

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
    checker.show(options["onlyconfig"])
  end

  def self.run(projectpath, options = {})
    Project.add_input_params(projectpath, options)
    require_dsl_and_script("teuton/case_manager/dsl") # Define DSL
  end

  def self.readme(projectpath, options = {})
    Project.add_input_params(projectpath, options)
    require_dsl_and_script("teuton/readme/main") # Define DSL
    readme = Readme.new(
      Project.value[:script_path],
      Project.value[:config_path]
    )
    readme.show
  end

  private_class_method def self.require_dsl_and_script(dslpath)
    require_relative dslpath
    begin
      require_relative Project.value[:script_path]
    rescue => e
      warn e
      warn Rainbow.new("[ERROR] #{e}:").red
      warn Rainbow.new("[ERROR] Reading file #{Project.value[:script_path]}").red
      exit 1
    end
  end
end
