
require_relative 'application'
require_relative 'utils'
require_relative 'case/main'
require_relative 'report'

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

    @tasks=Application.instance.groups
    @id=@@id; @@id+=1

    #Define Case Report
    @report = Report.new(@id)
    @report.filename=( @id<10 ? "case-0#{@id.to_s}" : "case-#{@id.to_s}" )
    @report.output_dir=File.join( 'var', @config.global[:tt_testname], 'out' )
    ensure_dir @report.output_dir

    #Default configuration
    @config.local[:tt_skip] = @config.local[:tt_skip] || false
    @mntdir = File.join( 'var', @config.get(:tt_testname), 'mnt', @id.to_s )
    @tmpdir = File.join( 'var', @config.get(:tt_testname), 'tmp' )
    @remote_tmpdir = File.join( '/', 'tmp' )

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
