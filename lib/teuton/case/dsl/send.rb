# frozen_string_literal: true

module DSL
  # * send, tempfile, tempdir, remote_tempdir, remote_tempfile
  def send(args = {})
    return if skip?

    return unless args[:copy_to]

    host = args[:copy_to].to_s
    return unless @conn_status[host].nil?

    ip = get(:"#{host}_ip")
    username = get(:"#{host}_username").to_s
    password = get(:"#{host}_password").to_s
    port = get(:"#{host}_port").to_i
    port = 22 if port.zero?

    filename = "#{@report.filename}.#{@report.format}"
    filename = "#{@report.filename}.txt" if @report.format == :colored_text
    localfilepath = File.join(@report.output_dir, filename)
    filename = args[:prefix].to_s + filename if args[:prefix]

    remotefilepath = if args[:dir]
      File.join(args[:dir], filename)
    else
      File.join(".", filename)
    end

    send_logpath = File.join(Project.value[:output_basedir], Project.value[:test_name], "send.log")
    send_logfile = File.open(send_logpath, "a")

    # Upload a file or directory to the remote host
    begin
      Net::SFTP.start(ip, username, password: password, port: port) do |sftp|
        sftp.upload!(localfilepath, remotefilepath)
      end
      msg = Rainbow("==> Case #{get(:tt_members)}: report (#{remotefilepath}) copy to (#{ip})").green
      verboseln(msg)
      send_logfile.write "#{msg}\n"
    rescue
      msg = Rainbow("==> [FAIL] #{get(:tt_members)}: 'scp #{localfilepath}' to #{remotefilepath}").red
      verboseln(msg)
      send_logfile.write "#{msg}\n"
    end
  end

  def tempfile(input = nil)
    return @action[:tempfile] if input.nil?

    name = input
    name = "teuton.tmp" if input == :default

    @action[:tempfile] = File.join(@tmpdir, name)
    @action[:remote_tempfile] = File.join(remote_tempdir, name)

    @action[:tempfile]
  end

  def tempdir
    @tmpdir
  end

  def remote_tempfile
    @action[:remote_tempfile]
  end

  def remote_tempdir
    File.join("/", "tmp") # TODO: Remove this?
  end
end
