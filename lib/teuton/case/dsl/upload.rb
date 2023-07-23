require_relative "../../utils/project"
require_relative "../../utils/verbose"

module DSL
  def upload(localfilter, args = {})
    abslocalfilter = if File.absolute_path? localfilter
      localfilter
    else
      File.join(Project.value[:project_path], localfilter)
    end

    Dir.glob(abslocalfilter).each do |abslocalpath|
      upload_one(abslocalpath, args)
    end
  end

  def upload_one(localpath, args = {})
    if args[:to].nil?
      Logger.err("ERROR upload requires to: XXX")
      exit 1
    end

    host = get_host(args[:to])
    if host.protocol == "ssh"
      begin
        localfile = File.basename(localpath)
        remotepath = args[:remotedir] ? File.join(args[:remotedir], localfile) : localfile
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
      msg = Rainbow("==> [ERROR] upload: Incorrect protocol(#{host.protocol})").red
      verboseln(msg)
    end
  end
end
