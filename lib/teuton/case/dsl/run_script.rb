require_relative "../../utils/project"
require_relative "../../utils/verbose"

module DSL
  def run_script(script, args = {})
    items = script.split(" ")
    if items.size == 1
      shell = args[:shell] || (get(:shell) != "NODATA" ? get(:shell) : nil)
      script = "#{shell} #{script}" if shell
      script = "#{script} #{args[:args]} " if args[:args]
    end

    items = script.split(" ")
    if items.size < 1
      msg = Rainbow("==> [ERROR] run_script: Incorrect command '#{command}'").red
      verboseln(msg)
      return
    end

    host = get_host(args[:on])
    if host.protocol == "local"
      items[1] = File.join(Project.value[:project_path], items[1])
      command = items.join(" ")
      run(command, args)
    elsif host.protocol == "ssh"
      upload items[1], to: host.id
      items[1] = File.basename(items[1])
      command = items.join(" ")
      run(command, args)
    else
      msg = Rainbow("==> [ERROR] run_script: Incorrect protocol(#{host.protocol})").red
      verboseln(msg)
    end
  end
end
