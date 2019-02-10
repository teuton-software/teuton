# encoding: utf-8

require_relative 'application'
require_relative 'utils'
require_relative 'case/config'
require_relative 'case/dsl/main'
require_relative 'case/result'
require_relative 'case/runner'

#TODO split Case class into several classes:
# * Case, Action?, Session?, RunCommand class

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
        m="GROUP: #{t[:name]}"
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
  alias_method :play, :start

  def close(uniques)
    fails = 0
    @uniques.each do |key|
      if uniques[key].include?(id) and uniques[key].count>1 then
        fails+=1
        log("UNIQUE:", :error)
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

end
