# frozen_string_literal: true

# Case->DSL#
# * send
# * tempfile
# * tempdir
# * remote_tempdir
# * remote_tempfile
module DSL
  def send(args = {})
    return if skip?

    return unless args[:copy_to]

    host = args[:copy_to].to_s
    return unless @conn_status[host].nil?

    ip = get((host + "_ip").to_sym)
    username = get((host + "_username").to_sym).to_s
    password = get((host + "_password").to_sym).to_s
    port = get((host + "_port").to_sym).to_i
    port = 22 if port.zero?

    filename = "#{@report.filename}.#{@report.format}"
    filename = "#{@report.filename}.txt" if @report.format == :colored_text
    localfilepath = File.join(@report.output_dir, filename)
    filename = args[:prefix].to_s + filename if args[:prefix]

    remotefilepath = if args[:remote_dir]
      File.join(args[:remote_dir], filename)
    else
      File.join(".", filename)
    end

    # Upload a file or directory to the remote host
    begin
      Net::SFTP.start(ip, username, password: password, port: port) do |sftp|
        sftp.upload!(localfilepath, remotefilepath)
      end
      msg = Rainbow("[ OK  ] #{(get(:tt_members)[0, 15]).ljust(16)} : #{remotefilepath}").green
      verboseln(msg)
    rescue
      msg = Rainbow("[ERROR] #{(get(:tt_members)[0, 15]).ljust(16)} : scp #{localfilepath} => #{remotefilepath}").red
      verboseln(msg)
    end
  end

  def tempfile(input = nil)
    return @action[:tempfile] if input.nil?

    name = input
    name = "teuton.tmp" if input == :default

    @action[:tempfile] = File.join(@tmpdir, name)
    @action[:remote_tempfile] = File.join(@remote_tmpdir, name)

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
