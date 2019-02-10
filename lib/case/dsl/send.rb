# encoding: utf-8

module DSL

  def send(pArgs={})
    return if get(:tt_skip)

    format=@report.format

    if pArgs[:copy_to] then

      host=pArgs[:copy_to].to_s
      ip=get((host+'_ip').to_sym)
      username = get((host+'_username').to_sym).to_s
      password = get((host+'_password').to_sym).to_s

      filename="case-#{id_to_s}.#{format}"
      localfilepath=File.join(tempdir,"../out/",filename)
      if pArgs[:prefix]
        filename=pArgs[:prefix].to_s+filename
      end

      if pArgs[:remote_dir]
        remotefilepath=File.join(pArgs[:remote_dir],filename)
      else
        remotefilepath=File.join(remote_tempdir,filename)
      end

      # upload a file or directory to the remote host
      begin
        Net::SFTP.start(ip, username, :password => password) do |sftp|
          sftp.upload!(localfilepath, remotefilepath)
        end
        verboseln("=> [ OK  ] #{get(:tt_members)}: <#{remotefilepath}>")
      rescue
        verboseln("=> [ERROR] #{get(:tt_members)}: scp <#{localfilepath}> => <#{remotefilepath}>")
      end
    end
  end

  def tempfile(pTempfile=nil)
    ext='.tmp'
    pre=@id.to_s+"-"
    if pTempfile.nil? then
      return @action[:tempfile]
    elsif pTempfile==:default
      @action[:tempfile]=File.join(@tmpdir, pre+'tt_local'+ext)
      @action[:remote_tempfile]=File.join(@remote_tmpdir, pre+'tt_remote'+ext)
    else
      @action[:tempfile]=File.join(@tmpdir, pre+pTempfile+ext)
      @action[:remote_tempfile]=File.join(@remote_tmpdir, pre+pTempfile+ext)
    end

  	return @action[:tempfile]
  end

  def tempdir
    @tmpdir
  end

  def remote_tempfile
    return @action[:remote_tempfile]
  end

  def remote_tempdir
    @remote_tmpdir
  end

end
