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
    raise ArgumentError, "upload requires 'to: XXX'" if args[:to].nil?

    host = get_host(args[:to])
    if host.protocol == "ssh"
      begin
        localfile = File.basename(localpath)
        remotepath = args[:remotedir] ? File.join(args[:remotedir], localfile) : localfile
        Net::SFTP.start(
          host.ip, host.username, password: host.password, port: host.port
        ) { |sftp| sftp.upload!(localpath, remotepath) }
        verbose(Rainbow(Settings.letter[:upload]).green)
      rescue => e
        log("Upload #{localfile} to #{host.ip}:#{remotepath}", :warn)
        log(e.to_s, :warn)
        verbose(Rainbow("!").green)
      end
    elsif host.protocol != "local"
      msg = Rainbow("==> [ERROR] upload: Incorrect protocol(#{host.protocol})").bright.red
      verboseln(msg)
    end
  end
end
