require_relative "../../utils/project"

module DSL
  def run_file(command, args = {})
    # Copy script to remote host
    puts Project.value[:project_path]
    run(command, args)
  end
end
