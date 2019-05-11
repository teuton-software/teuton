# Case->DSL#
# * send
# * tempfile
# * tempdir
# * remote_tempdir
# * remote_tempfile
module DSL
  def send(args = {})
    return if get(:tt_skip)

    return unless args[:copy_to]

    host = args[:copy_to].to_s
    ip = get((host + '_ip').to_sym)
    username = get((host + '_username').to_sym).to_s
    password = get((host + '_password').to_sym).to_s

    filename = @report.filename + '.' + @report.format.to_s
    localfilepath = File.join(tempdir, '../out/', filename)
    filename = args[:prefix].to_s + filename if args[:prefix]

    if args[:remote_dir]
      remotefilepath = File.join(args[:remote_dir], filename)
    else
      remotefilepath = File.join(remote_tempdir, filename)
    end

    # Upload a file or directory to the remote host
    begin
      Net::SFTP.start(ip, username, password: password) do |sftp|
        sftp.upload!(localfilepath, remotefilepath)
      end
      verboseln("=> [ OK  ] #{get(:tt_members)}: <#{remotefilepath}>")
    rescue
      verboseln("=> [ERROR] #{get(:tt_members)}: scp <#{localfilepath}> => <#{remotefilepath}>")
    end
  end

  def tempfile(input = nil)
    return @action[:tempfile] if input.nil?

    localname = @id.to_s + '-tt_local.tmp'
    remotename = @id.to_s + '-tt_remote.tmp'
    if input == :default
      localname = @id.to_s + '-tt_local.tmp'
      remotename = @id.to_s + '-tt_remote.tmp'
    else
      localname = @id.to_s + "-#{input}.tmp"
      remotename = @id.to_s + "-#{input}.tmp"
    end
    @action[:tempfile] = File.join(@tmpdir, localname)
    @action[:remote_tempfile] = File.join(@remote_tmpdir, remotename)

    @action[:tempfile]
  end

  def tempdir
    @tmpdir
  end

  def remote_tempfile
    @action[:remote_tempfile]
  end

  def remote_tempdir
    @remote_tmpdir
  end
end
