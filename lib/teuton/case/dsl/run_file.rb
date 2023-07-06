require_relative "../../utils/project"

module DSL
  def run_file(script, args = {})
    # ip = config.get("#{args[:host]}_ip".to_sym)
    #if args[:host].nil? || ip == "127.0.0.1"
    host = get_host(args[:on])
    if host.protocol == "local"
      command = File.join(Project.value[:project_path], script)
    else
      # Copy script to remote host
      items = script.split(" ")
      items[0].gsub!(File::SEPARATOR, "_")
      file = items[0]
      command = items.join(" ")
      puts "Uploading #{file} to #{host}"
    end
    run(command, args)
  end
end
