require_relative "../../utils/project"

module DSL
  def run_file(script, args = {})
    host = get_host(args[:host])
    ip = config.get("#{args[:host]}_ip".to_sym)
    # Copy script to remote host
    if args[:host].nil? || ip == "127.0.0.1"
      command = File.join(Project.value[:project_path], script)
      puts "DEBUG #{ip} local run: #{command}"
    else
      command = script
      puts "DEBUG #{ip} remote run: #{command}"
    end
    run(command, args)
  end
end
