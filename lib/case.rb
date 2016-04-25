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
  
end
