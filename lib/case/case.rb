# encoding: utf-8

require 'net/ssh'
require 'net/sftp'
require 'net/telnet'

require_relative '../application'
require_relative '../utils'
require_relative 'config'
require_relative 'dsl'
require_relative 'result'

#TODO split Case class into several classes: Case, Action?, Session?, RunCommand class

class Case
  include DSL
  include Utils

  attr_accessor :result, :action
  attr_reader :id, :config, :report, :uniques
  @@id=1

  def initialize(pConfig)
    @config = Case::Config.new( :local => pConfig, :global => Application.instance.global)

    @tasks=Application.instance.tasks
    @id=@@id; @@id+=1

    #Define Case Report
    @report = Report.new(@id)
    @report.filename=( @id<10 ? "case-0#{@id.to_s}" : "case-#{@id.to_s}" )
    @report.output_dir=File.join( "var", @config.global[:tt_testname], "out" )
    ensure_dir @report.output_dir

    #Default configuration
    @config.local[:tt_skip] = @config.local[:tt_skip] || false
    @mntdir = File.join( "var", @config.get(:tt_testname), "mnt", @id.to_s )
    @tmpdir = File.join( "var", @config.get(:tt_testname), "tmp" )
    @remote_tmpdir = File.join( "/", "tmp" )

    ensure_dir @mntdir
    ensure_dir @tmpdir

    @unique_values={}
    @result = Result.new
    @result.reset

    @debug=Application.instance.debug
    @verbose=Application.instance.verbose

    @action_counter=0
    @action={ :id => 0, :weight => 1.0, :description => 'Empty description!'}
    @uniques=[]
    @sessions={}
    tempfile :default
  end

  def skip
    @config.get(:tt_skip)
  end

  def start
    @skip=get(:tt_skip)||false
    if @skip==true then
      verbose "Skipping case <#{@config.get(:tt_members)}>\n"
      return false
    end

    names=@id.to_s+"-*.tmp"
    r=`ls #{@tmpdir}/#{names} 2>/dev/null | wc -l`
    execute("rm #{@tmpdir}/#{names}") if r[0].to_i>0 #Delete previous temp files

    start_time = Time.now
    if get(:tt_sequence) then
      verboseln "Starting case <"+@config.get(:tt_members)+">"
      @tasks.each do |t|
        verbose "* Processing <"+t[:name].to_s+"> "
        instance_eval &t[:block]
        verbose "\n"
      end
      verboseln "\n"
    else
      @tasks.each do |t|
        m="TASK: #{t[:name]}"
        log("="*m.size)
        log(m)
        instance_eval &t[:block]
      end
    end

    finish_time=Time.now
    @report.head.merge! @config.local
    @report.tail[:case_id]=@id
    @report.tail[:start_time_]=start_time
    @report.tail[:finish_time]=finish_time
    @report.tail[:duration]=finish_time-start_time

    @sessions.each_value { |s| s.close if s.class==Net::SSH::Connection::Session }
  end

  def close(uniques)
    fails = 0
    @uniques.each do |key|
      if uniques[key].include?(id) and uniques[key].count>1 then
        fails+=1
        log("Unique:", :error)
        begin
          log("   ├── Value     => #{key.to_s}", :error)
         rescue Exception => e
          log(key, :error)
          log(e.to_s, :error)
        end
        begin
          log("   └── Conflicts => #{uniques[key].to_s}", :error)
         rescue Exception => e
          log(e.to_s, :error)
        end
      end
    end
    @report.tail[:unique_fault]=fails
    @report.close
  end

  def id_to_s
    return id.to_s if id>9
    return "0"+id.to_s
  end

private

  def read_filename(psFilename)
    begin
      lFile = File.open(psFilename,'r')
      lItem = lFile.readlines
      lFile.close

      lItem.map! { |i| i.sub(/\n/,"") }

      return lItem
    rescue
      return []
    end
  end

  def run_local_cmd
    @action[:conn_type]=:local
    @result.content = my_execute( @action[:command] )
  end

  def run_remote_cmd(pHostname)
    hostname=pHostname.to_s
    protocol=@config.get((hostname+'_protocol').to_sym) if @config.get((hostname+'_protocol').to_sym)
    protocol=:ssh if protocol.nil? or protocol=="NODATA"
    protocol=protocol.to_sym

    case protocol
    when :ssh
      run_remote_cmd_ssh(pHostname)
    when :telnet
      run_remote_cmd_telnet(pHostname)
    else
      raise "Unkown remote protocol <#{protocol.to_s}>"
    end
  end

  def run_remote_cmd_ssh(pHostname)
    @action[:conn_type]=:ssh
    app=Application.instance
    hostname=pHostname.to_s
    ip=@config.get((hostname+'_ip').to_sym)
    username=@config.get((hostname+'_username').to_sym)
    password=@config.get((hostname+'_password').to_sym)
    output=[]

    begin
      if @sessions[hostname].nil?
        @sessions[hostname] = Net::SSH.start(ip, username, :password => password)
      end

      if @sessions[hostname].class==Net::SSH::Connection::Session
        text=@sessions[hostname].exec!( @action[:command] )
        output = text.split("\n")
      end

    rescue Errno::EHOSTUNREACH
      @sessions[hostname]=:nosession
      verbose app.letter[:error]
      log( "Host #{ip} unreachable!", :error)
    rescue Net::SSH::AuthenticationFailed
      @sessions[hostname]=:nosession
      verbose app.letter[:error]
      log( "SSH::AuthenticationFailed!", :error)
    rescue Net::SSH::HostKeyMismatch
      @sessions[hostname]=:nosession
      verbose app.letter[:error]
      log('SSH::HostKeyMismatch!', :error)
      log("* The destination server's fingerprint is not matching what is in your local known_hosts file.",:error)
      log('* Remove the existing entry in your local known_hosts file', :error)
      log("* Try this => ssh-keygen -f '/home/USERNAME/.ssh/known_hosts' -R #{ip}", :error)
    rescue Exception => e
      @sessions[hostname] = :nosession
      verbose app.letter[:error]
      log( "[#{e.class}] SSH on <#{username}@#{ip}> exec: " + @action[:command], :error)
    end

    @result.content=output
    @result.content.compact!
  end

  def run_remote_cmd_telnet(pHostname)
    @action[:conn_type] = :telnet
    app = Application.instance
    hostname = pHostname.to_s
    ip = @config.get((hostname+'_ip').to_sym)
    username = @config.get((hostname+'_username').to_sym)
    password = @config.get((hostname+'_password').to_sym)
    output = []

    begin
      if @sessions[hostname].nil? || @sessions[hostname] == :ok
        #h = Net::Telnet::new({ 'Host' => ip, 'Timeout' => 40, 'Prompt' => Regexp.new(username) })
        h = Net::Telnet::new({ 'Host' => ip, 'Timeout' => 10, 'Prompt' => Regexp.new(username[1,40]) })

          #'Prompt' => /[$%#>]\s?\z/n })
        h.login(username, password)
        text = ''
        h.cmd(@action[:command]) { |i| text << i }
        output=text.split("\n")
        h.close
        @sessions[hostname] = :ok
      end

    rescue Net::OpenTimeout
      @sessions[hostname] = :nosession
      verbose app.letter[:error]
      log(" ExceptionType=<Net::OpenTimeout> doing <telnet #{ip}>", :error)
      log(' └── Revise host IP!', :warn)
    rescue Net::ReadTimeout
      @sessions[hostname] = :nosession
      verbose app.letter[:error]
      log(" ExceptionType=<Net::ReadTimeout> doing <telnet #{ip}>", :error)
    rescue Exception => e
      @sessions[hostname] = :nosession
      verbose app.letter[:error]
      log(" ExceptionType=<#{e.class}> doing telnet on <#{username}@#{ip}> exec: " + @action[:command], :error)
      log(" └── username=<#{username}>, password=<#{password}>, ip=<#{ip}>, HOSTID=<#{hostname}>", :warn)
    end

    @result.content = output
  end
end
