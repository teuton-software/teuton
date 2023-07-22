require_relative "../../utils/project"
require_relative "../../utils/verbose"

module DSL
  def upload(localfiles, args = {})
    localpaths = if File.absolute_path? localfiles
      localfiles
    else
      File.join(Project.value[:project_path], localfiles)
    end

    Dir.glob(localpaths).each do |localpath|
      upload_one(localpath, args)
    end
  end

  def upload_one(localpath, args = {})
    localfile = File.basename(localpath)
    host = get_host(args[:to])
    if host.protocol == "ssh"
      begin
        remotepath = args[:remotepath] || localfile
        Net::SFTP.start(
          host.ip, host.username, password: host.password, port: host.port
        ) { |sftp| sftp.upload!(localpath, remotepath) }
        verbose(Rainbow("u").green)
      rescue => e
        log("Upload #{localfile} to #{host.ip}:#{remotepath}", :warn)
        log(e.to_s, :warn)
        verbose(Rainbow("!").green)
      end
    elsif host.protocol != "local"
      msg = Rainbow("==> [ERROR] run_file: Incorrect protocol(#{host.protocol})").red
      verboseln(msg)
    end
  end
end
