# encoding: utf-8

require 'net/ssh'
require 'net/sftp'

require_relative 'application'
require_relative 'case/dsl'
require_relative 'case/result'
require_relative 'utils'

class Case
  include DSL
  include Utils

  attr_accessor :result
  attr_reader :id, :report, :uniques
  @@id=1

  def initialize(pConfig)
    @global_config  = Application.instance.global
    @case_config    = pConfig
    @running_config = {}
    
    @tasks=Application.instance.tasks
    @id=@@id; @@id+=1
				
    #Define Case Report
    @report = Report.new(@id)
    @report.filename=( @id<10 ? "case-0#{@id.to_s}" : "case-#{@id.to_s}" )
    @report.outdir=File.join( "var", @global_config[:tt_testname], "out" )
    ensure_dir @report.outdir
		
    #Default configuration
    @case_config[:tt_skip] = @case_config[:tt_skip] || false
    @mntdir = File.join( "var", get(:tt_testname), "mnt", @id.to_s )
    @tmpdir = File.join( "var", get(:tt_testname), "tmp" )
    @remote_tmpdir = File.join( "/", "tmp" )

    ensure_dir @mntdir
    ensure_dir @tmpdir

    @unique_values={}
    @result = Result.new
    @result.reset

    @debug=Tool.instance.is_debug?
    @verbose=Tool.instance.is_verbose?
	
    @action_counter=0		
    @action={ :id => 0, :weight => 1.0, :description => 'Empty description!'}
    @uniques=[]
    @sessions={}	
    tempfile :default
  end

  def start
    lbSkip=get(:tt_skip)||false
    if lbSkip==true then
      verbose "Skipping case <#{get(:tt_members)}>\n"
      return false
    end

    names=@id.to_s+"-*.tmp"
    r=`ls #{@tmpdir}/#{names} 2>/dev/null | wc -l`
    execute("rm #{@tmpdir}/#{names}") if r[0].to_i>0 #Detele previous temp files
		
    start_time = Time.now		
    if get(:tt_sequence) then
      verboseln "Starting case <"+get(:tt_members)+">"
      @tasks.each do |t|
        verbose "* Processing <"+t[:name].to_s+"> "
        instance_eval &t[:block]
        verbose "\n"
      end
      verboseln "\n"
    else
      @tasks.each do |t|
        msg="TASK: #{t[:name]}" 
        log("="*msg.size)
        log(msg)
        instance_eval &t[:block]
      end
    end

    finish_time=Time.now
    @report.head.merge! @case_config
    @report.tail[:case_id]=@id
    @report.tail[:start_time_]=start_time
    @report.tail[:finish_time]=finish_time
    @report.tail[:duration]=finish_time-start_time		

    @sessions.each_value { |s| s.close if s.class==Net::SSH::Connection::Session }
  end
	
  def close(uniques)
    fails=0
    @uniques.each do |key|
      if uniques[key].include?(id) and uniques[key].count>1 then
        fails+=1
        log("Unique:", :error)
        log("   ├── Value     => #{key.to_s}", :error)
        log("   └── Conflicts => #{uniques[key].to_s}", :error)
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
    @result.content = my_execute( @action[:command] )	
  end

  def run_remote_cmd(pHostname)
    hostname=pHostname.to_s
    protocol=get((hostname+'_protocol').to_sym) if get((hostname+'_protocol').to_sym)
    protocol=:ssh if protocol.nil?
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
    app=Application.instance 		
    hostname=pHostname.to_s
    ip=get((hostname+'_ip').to_sym)
    username=get((hostname+'_username').to_sym)
    password=get((hostname+'_password').to_sym)
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
      log( "SSH::HostKeyMismatch!", :error)
      log( "* The destination server's fingerprint is not matching what is in your local known_hosts file.",:error)
      log( "* Remove the existing entry in your local known_hosts file", :error)
      log( "* Try this => ssh-keygen -f '/home/USERNAME/.ssh/known_hosts' -R #{ip}", :error)
    rescue Exception => e
      @sessions[hostname]=:nosession
      verbose app.letter[:error]
      log( "[#{e.class.to_s}] SSH on <#{username}@#{ip}> exec: "+@action[:command], :error)
    end
		
    @result.content=output
    @result.content.compact!
  end

  def run_remote_cmd_telnet(pHostname) 	
    app=Application.instance
    hostname=pHostname.to_s
    ip=get((hostname+'_ip').to_sym)
    username=get((hostname+'_username').to_sym)
    password=get((hostname+'_password').to_sym)
    output=[]

    begin
      if @sessions[hostname].nil? or @sessions[hostname]==:ok
        h = Net::Telnet::new( { "Host"=>ip, "Timeout"=>30, "Prompt"=>/sysadmingame/ })
        h.login( username, password)
        text=""
        h.cmd(@action[:command]) {|i| text << i}
        output=text.split("\n")
        h.close      
        @sessions[hostname] = :ok
      end

    rescue Net::OpenTimeout
      @sessions[hostname] = :nosession
      verbose app.letter[:error]
      log( " ExceptionType=<Net::OpenTimeout> doing <telnet #{ip}>", :error)
      log( " └── Revise host IP!", :warn)
    rescue Net::ReadTimeout
      @sessions[hostname] = :nosession
      verbose app.letter[:error]
      log( " ExceptionType=<Net::ReadTimeout> doing <telnet #{ip}>", :error)
    rescue Exception => e
      @sessions[hostname] = :nosession
      verbose app.letter[:error]
      log( " ExceptionType=<#{e.class.to_s}> doing telnet on <#{username}@#{ip}> exec: "+@action[:command], :error)
      log( " └── username=<#{username}>, password=<#{password}>, ip=<#{ip}>, HOSTID=<#{hostname}>", :warn)
    end

    @result.content=output
  end

end
